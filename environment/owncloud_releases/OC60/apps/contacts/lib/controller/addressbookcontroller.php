<?php
/**
 * @author Thomas Tanghus
 * Copyright (c) 2013 Thomas Tanghus (thomas@tanghus.net)
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

namespace OCA\Contacts\Controller;

use OCA\Contacts\App,
	OCA\Contacts\JSONResponse,
	OCA\Contacts\Utils\JSONSerializer,
	OCA\Contacts\Controller,
	OCP\AppFramework\Http;

/**
 * Controller class For Address Books
 */
class AddressBookController extends Controller {

	/**
	 * @NoAdminRequired
	 * @NoCSRFRequired
	 */
	public function userAddressBooks() {
		$addressBooks = $this->app->getAddressBooksForUser();
		$result = array();
		$lastModified = 0;
		foreach($addressBooks as $addressBook) {
			$data = $addressBook->getMetaData();
			$result[] = $data;
			if(!is_null($data['lastmodified'])) {
				$lastModified = max($lastModified, $data['lastmodified']);
			}
		}

		// To avoid invalid cache deletion time is saved
		$lastModified = max(
			$lastModified,
			\OCP\Config::getUserValue($this->api->getUserId(), 'contacts', 'last_address_book_deleted', 0)
		);

		$response = new JSONResponse(array(
			'addressbooks' => $result,
		));

		/** FIXME: Caching is currently disabled
		if($lastModified > 0) {
			$response->setLastModified(\DateTime::createFromFormat('U', $lastModified) ?: null);
			$response->setETag(md5($lastModified));
		}
		*/

		return $response;
	}

	/**
	 * @NoAdminRequired
	 * @NoCSRFRequired
	 */
	public function getAddressBook() {
		$params = $this->request->urlParams;

		$addressBook = $this->app->getAddressBook($params['backend'], $params['addressBookId']);
		$lastModified = $addressBook->lastModified();
		$etag = null;
		$response = new JSONResponse();

		if(!is_null($lastModified)) {
			//$response->addHeader('Cache-Control', 'private, must-revalidate');
			$response->setLastModified(\DateTime::createFromFormat('U', $lastModified) ?: null);
			$etag = md5($lastModified);
			$response->setETag($etag);
		}

		//$response->debug('comparing: "' . $etag . '" to ' . $this->request->getHeader('If-None-Match'));
		if(!is_null($etag)
			&& $this->request->getHeader('If-None-Match') === '"'.$etag.'"')
		{
			return $response->setStatus(Http::STATUS_NOT_MODIFIED);
		} else {
			$contacts = array();
			foreach($addressBook->getChildren() as $i => $contact) {
				$result = JSONSerializer::serializeContact($contact);
				if($result !== null) {
					$contacts[] = $result;
				}
			}
			return $response->setData(array('contacts' => $contacts));
		}
	}

	/**
	 * @NoAdminRequired
	 */
	public function addAddressBook() {
		$params = $this->request->urlParams;

		$response = new JSONResponse();

		$backend = $this->app->getBackend($params['backend']);
		if(!$backend->hasAddressBookMethodFor(\OCP\PERMISSION_CREATE)) {
			throw new \Exception('This backend does not support adding address books', 501);
		}
		try {
			$id = $backend->createAddressBook($this->request->post);
		} catch(Exception $e) {
			return $response->bailOut($e->getMessage());
		}
		if($id === false) {
			return $response->bailOut(App::$l10n->t('Error creating address book'));
		}

		return $response->setStatus('201')->setParams($backend->getAddressBook($id));
	}

	/**
	 * @NoAdminRequired
	 */
	public function updateAddressBook() {
		$params = $this->request->urlParams;

		$response = new JSONResponse();

		$addressBook = $this->app->getAddressBook($params['backend'], $params['addressBookId']);
		try {
			if(!$addressBook->update($this->request['properties'])) {
				return $response->bailOut(App::$l10n->t('Error updating address book'));
			}
		} catch(Exception $e) {
			return $response->bailOut($e->getMessage());
		}
		return $response->setParams($addressBook->getMetaData());
	}

	/**
	 * @NoAdminRequired
	 */
	public function deleteAddressBook() {
		$params = $this->request->urlParams;

		$response = new JSONResponse();

		$backend = $this->app->getBackend($params['backend']);

		if(!$backend->hasAddressBookMethodFor(\OCP\PERMISSION_DELETE)) {
			throw new \Exception(
				'The "%s" backend does not support deleting address books', array($backend->name)
			);
		}

		$addressBookInfo = $backend->getAddressBook($params['addressBookId']);

		if(!$addressBookInfo['permissions'] & \OCP\PERMISSION_DELETE) {
			return $response->bailOut(App::$l10n->t(
				'You do not have permissions to delete the "%s" address book'),
				array($addressBookInfo['displayname']
			));
		}

		if(!$backend->deleteAddressBook($params['addressBookId'])) {
			return $response->bailOut(App::$l10n->t('Error deleting address book'));
		}
		\OCP\Config::setUserValue($this->api->getUserId(), 'contacts', 'last_address_book_deleted', time());
		return $response;
	}

	/**
	 * @NoAdminRequired
	 */
	public function activateAddressBook() {
		$params = $this->request->urlParams;

		$response = new JSONResponse();

		$addressBook = $this->app->getAddressBook($params['backend'], $params['addressBookId']);

		$addressBook->setActive($this->request->post['state']);

		return $response;
	}

	/**
	 * @NoAdminRequired
	 */
	public function addChild() {
		$params = $this->request->urlParams;

		$response = new JSONResponse();

		$addressBook = $this->app->getAddressBook($params['backend'], $params['addressBookId']);

		try {
			$id = $addressBook->addChild();
		} catch(Exception $e) {
			return $response->bailOut($e->getMessage());
		}

		if($id === false) {
			return $response->bailOut(App::$l10n->t('Error creating contact.'));
		}

		$contact = $addressBook->getChild($id);
		$response->setStatus('201');
		$response->setETag($contact->getETag());
		$response->addHeader('Location',
			\OCP\Util::linkToRoute(
				'contacts_contact_get',
				array(
					'backend' => $params['backend'],
					'addressBookId' => $params['addressBookId'],
					'contactId' => $id
				)
			)
		);
		return $response->setParams(JSONSerializer::serializeContact($contact));
	}

	/**
	 * @NoAdminRequired
	 */
	public function deleteChild() {
		$params = $this->request->urlParams;

		$response = new JSONResponse();

		$addressBook = $this->app->getAddressBook($params['backend'], $params['addressBookId']);

		try {
			$result = $addressBook->deleteChild($params['contactId']);
		} catch(Exception $e) {
			return $response->bailOut($e->getMessage());
		}

		if($result === false) {
			return $response->bailOut(App::$l10n->t('Error deleting contact.'));
		}
		return $response->setStatus('204');
	}

	/**
	 * @NoAdminRequired
	 */
	public function deleteChildren() {
		$params = $this->request->urlParams;

		$response = new JSONResponse();

		$addressBook = $this->app->getAddressBook($params['backend'], $params['addressBookId']);
		$contacts = $this->request->post['contacts'];

		try {
			$result = $addressBook->deleteChildren($contacts);
		} catch(Exception $e) {
			return $response->bailOut($e->getMessage());
		}

		return $response->setParams(array('result' => $result));
	}

	/**
	 * @NoAdminRequired
	 */
	public function moveChild() {
		$params = $this->request->urlParams;
		$targetInfo = $this->request->post['target'];

		$response = new JSONResponse();

		// TODO: Check if the backend supports move (is 'local' or 'shared') and use that operation instead.
		// If so, set status 204 and don't return the serialized contact.
		$fromAddressBook = $this->app->getAddressBook($params['backend'], $params['addressBookId']);
		$targetAddressBook = $this->app->getAddressBook($targetInfo['backend'], $targetInfo['id']);
		$contact = $fromAddressBook->getChild($params['contactId']);
		if(!$contact) {
			$response->bailOut(App::$l10n->t('Error retrieving contact.'));
			return $response;
		}
		try {
			$contactId = $targetAddressBook->addChild($contact);
		} catch(Exception $e) {
			return $response->bailOut($e->getMessage());
		}
		$contact = $targetAddressBook->getChild($contactId);
		if(!$contact) {
			return $response->bailOut(App::$l10n->t('Error saving contact.'));
		}
		if(!$fromAddressBook->deleteChild($params['contactId'])) {
			// Don't bail out because we have to return the contact
			return $response->debug(App::$l10n->t('Error removing contact from other address book.'));
		}
		return $response->setParams(JSONSerializer::serializeContact($contact));
	}

}

