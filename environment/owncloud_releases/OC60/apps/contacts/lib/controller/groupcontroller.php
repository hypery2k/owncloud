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
	OCA\Contacts\Controller;

/**
 * Controller class for groups/categories
 */
class GroupController extends Controller {

	/**
	 * @NoAdminRequired
	 */
	public function getGroups() {
		$tagMgr = $this->server->getTagManager()->load('contact');
		$tags = $tagMgr->getTags();
		foreach($tags as &$tag) {
			try {
			$ids = $tagMgr->getIdsForTag($tag['name']);
			$tag['contacts'] = $ids;
			} catch(\Exception $e) {
				$this->api->log(__METHOD__ . ' ' . $e->getMessage());
			}
		}

		$favorites = $tagMgr->getFavorites();

		$groups = array(
			'categories' => $tags,
			'favorites' => $favorites,
			'shared' => \OCP\Share::getItemsSharedWith('addressbook', \OCA\Contacts\Share\Addressbook::FORMAT_ADDRESSBOOKS),
			'lastgroup' => \OCP\Config::getUserValue($this->api->getUserId(), 'contacts', 'lastgroup', 'all'),
			'sortorder' => \OCP\Config::getUserValue($this->api->getUserId(), 'contacts', 'groupsort', ''),
			);

		return new JSONResponse($groups);
	}

	/**
	 * @NoAdminRequired
	 */
	public function addGroup() {
		$name = $this->request->post['name'];

		$response = new JSONResponse();
		if(is_null($name) || $name === "") {
			$response->bailOut(App::$l10n->t('No group name given.'));
		}

		$tagMgr = $this->server->getTagManager()->load('contact');
		$id = $tagMgr->add($name);

		if($id === false) {
			$response->bailOut(App::$l10n->t('Error adding group.'));
		} else {
			$response->setParams(array('id'=>$id, 'name' => $name));
		}
		return $response;
	}

	/**
	 * @NoAdminRequired
	 */
	public function deleteGroup() {
		$name = $this->request->post['name'];

		$response = new JSONResponse();
		if(is_null($name) || $name === '') {
			$response->bailOut(App::$l10n->t('No group name given.'));
			return $response;
		}

		$tagMgr = $this->server->getTagManager()->load('contact');
		try {
			$ids = $tagMgr->getIdsForTag($name);
		} catch(\Exception $e) {
			$response->setErrorMessage($e->getMessage());
			return $response;
		}
		if($ids !== false) {
			$backend = $this->app->getBackend('local');
			foreach($ids as $id) {
				$contact = $backend->getContact(null, $id, array('noCollection' => true));
				$obj = \Sabre\VObject\Reader::read(
					$contact['carddata'],
					\Sabre\VObject\Reader::OPTION_IGNORE_INVALID_LINES
				);
				if($obj) {
					if(!$obj->inGroup($name)) {
						continue;
					}
					if($obj->removeFromGroup($name)) {
						$backend->updateContact(null, $id, $obj, array('noCollection' => true, 'isBatch' => true));
					}
				} else {
					\OCP\Util::writeLog('contacts', __METHOD__.', could not parse card ' . $id, \OCP\Util::DEBUG);
				}
			}
		}
		try {
			$tagMgr->delete($name);
		} catch(\Exception $e) {
			$response->setErrorMessage($e->getMessage());
		}
		return $response;
	}

	/**
	 * @NoAdminRequired
	 */
	public function renameGroup() {
		$from = $this->request->post['from'];
		$to = $this->request->post['to'];

		$response = new JSONResponse();
		if(is_null($from) || $from === '') {
			$response->bailOut(App::$l10n->t('No group name to rename from given.'));
			return $response;
		}
		if(is_null($to) || $to === '') {
			$response->bailOut(App::$l10n->t('No group name to rename to given.'));
			return $response;
		}

		$tagMgr = $this->server->getTagManager()->load('contact');
		if(!$tagMgr->rename($from, $to)) {
			$response->bailOut(App::$l10n->t('Error renaming group.'));
			return $response;
		}
		$ids = $tagMgr->getIdsForTag($to);
		if($ids !== false) {
			$backend = $this->app->getBackend('local');
			foreach($ids as $id) {
				$contact = $backend->getContact(null, $id, array('noCollection' => true));
				$obj = \Sabre\VObject\Reader::read(
					$contact['carddata'],
					\Sabre\VObject\Reader::OPTION_IGNORE_INVALID_LINES
				);
				if($obj) {
					if(!isset($obj->CATEGORIES)) {
						continue;
					}
					$obj->CATEGORIES->renameGroup($from, $to);
					$backend->updateContact(null, $id, $obj, array('noCollection' => true));
				} else {
					\OCP\Util::writeLog('contacts', __METHOD__.', could not parse card ' . $id, \OCP\Util::DEBUG);
				}
			}
		}
		return $response;
	}

	/**
	 * @NoAdminRequired
	 */
	public function addToGroup() {
		$response = new JSONResponse();
		$params = $this->request->urlParams;
		$categoryId = $params['categoryId'];
		$categoryname = $this->request->post['name'];
		$ids = $this->request->post['contactIds'];
		$response->debug('request: '.print_r($this->request->post, true));

		if(is_null($categoryId) || $categoryId === '') {
			$response->bailOut(App::$l10n->t('Group ID missing from request.'));
			return $response;
		}

		if(is_null($categoryId) || $categoryId === '') {
			$response->bailOut(App::$l10n->t('Group name missing from request.'));
			return $response;
		}

		if(is_null($ids)) {
			$response->bailOut(App::$l10n->t('Contact ID missing from request.'));
			return $response;
		}

		$backend = $this->app->getBackend('local');
		$tagMgr = $this->server->getTagManager()->load('contact');
		foreach($ids as $contactId) {
			$contact = $backend->getContact(null, $contactId, array('noCollection' => true));
			$obj = \Sabre\VObject\Reader::read(
				$contact['carddata'],
				\Sabre\VObject\Reader::OPTION_IGNORE_INVALID_LINES
			);
			if($obj) {
				if($obj->addToGroup($categoryname)) {
					$backend->updateContact(null, $contactId, $obj, array('noCollection' => true));
				}
			}
			$response->debug('contactId: ' . $contactId . ', categoryId: ' . $categoryId);
			$tagMgr->tagAs($contactId, $categoryId);
		}

		return $response;
	}

	/**
	 * @NoAdminRequired
	 */
	public function removeFromGroup() {
		$response = new JSONResponse();
		$params = $this->request->urlParams;
		$categoryId = $params['categoryId'];
		$categoryname = $this->request->post['name'];
		$ids = $this->request->post['contactIds'];
		//$response->debug('request: '.print_r($this->request->post, true));

		if(is_null($categoryId) || $categoryId === '') {
			$response->bailOut(App::$l10n->t('Group ID missing from request.'));
			return $response;
		}

		if(is_null($ids)) {
			$response->bailOut(App::$l10n->t('Contact ID missing from request.'));
			return $response;
		}

		$backend = $this->app->getBackend('local');
		$tagMgr = $this->server->getTagManager()->load('contact');
		foreach($ids as $contactId) {
			$contact = $backend->getContact(null, $contactId, array('noCollection' => true));
			if(!$contact) {
				$response->debug('Couldn\'t get contact: ' . $contactId);
				continue;
			}
			$obj = \Sabre\VObject\Reader::read(
				$contact['carddata'],
				\Sabre\VObject\Reader::OPTION_IGNORE_INVALID_LINES
			);
			if($obj) {
				if(!isset($obj->CATEGORIES)) {
					return $response;
				}
				if($obj->removeFromGroup($categoryname)) {
					$backend->updateContact(null, $contactId, $obj, array('noCollection' => true));
				}
			} else {
				$response->debug('Error parsing contact: ' . $contactId);
			}
			$response->debug('contactId: ' . $contactId . ', categoryId: ' . $categoryId);
			$tagMgr->unTag($contactId, $categoryId);
		}

		return $response;
	}

}

