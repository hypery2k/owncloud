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
	OCA\Contacts\ImageResponse,
	OCA\Contacts\Utils\Properties,
	OCA\Contacts\Controller;

/**
 * Controller class For Contacts
 */
class ContactPhotoController extends Controller {

	/**
	 * @NoAdminRequired
	 * @NoCSRFRequired
	 */
	public function getPhoto($maxSize = 170) {
		// TODO: Cache resized photo
		$params = $this->request->urlParams;
		$etag = null;

		\OCP\Util::writeLog('contacts',
			__METHOD__.' backend: '.$params['backend'].', ab; '.$params['addressBookId'].', contact: '.$params['contactId'],
			\OCP\Util::DEBUG
		);
		$addressBook = $this->app->getAddressBook($params['backend'], $params['addressBookId']);
		$contact = $addressBook->getChild($params['contactId']);

		if(!$contact) {
			$response = new JSONResponse();
			$response->bailOut(App::$l10n->t('Couldn\'t find contact.'));
			return $response;
		}

		$image = new \OCP\Image();
		if (isset($contact->PHOTO) && $image->loadFromBase64((string)$contact->PHOTO)) {
			// OK
			$etag = md5($contact->PHOTO);
		}
		else
		// Logo :-/
		if(isset($contact->LOGO) && $image->loadFromBase64((string)$contact->LOGO)) {
			// OK
			$etag = md5($contact->LOGO);
		}
		if($image->valid()) {
			$response = new ImageResponse($image);
			$lastModified = $contact->lastModified();
			// Force refresh if modified within the last minute.
			if(!is_null($lastModified)) {
				$response->setLastModified(\DateTime::createFromFormat('U', $lastModified) ?: null);
			}
			if(!is_null($etag)) {
				$response->setETag($etag);
			}
			if ($image->width() > $maxSize || $image->height() > $maxSize) {
				$image->resize($maxSize);
			}
			return $response;
		} else {
			$response = new JSONResponse();
			$response->bailOut(App::$l10n->t('Error getting user photo'));
			return $response;
		}
	}

	/**
	 * Uploads a photo and saves in oC cache
	 * @return JSONResponse with data.tmp set to the key in the cache.
	 *
	 * @NoAdminRequired
	 * @NoCSRFRequired
	 */
	public function uploadPhoto() {
		$params = $this->request->urlParams;
		$maxSize = isset($this->request->post['maxSize']) ? $this->request->post['maxSize'] : 400;

		$response = new JSONResponse();

		if (!isset($this->request->files['imagefile'])) {
			$response->bailOut(App::$l10n->t('No file was uploaded. Unknown error'));
			return $response;
		}

		$file = $this->request->files['imagefile'];
		$error = $file['error'];
		if($error !== UPLOAD_ERR_OK) {
			$errors = array(
				0=>App::$l10n->t("There is no error, the file uploaded with success"),
				1=>App::$l10n->t("The uploaded file exceeds the upload_max_filesize directive in php.ini").ini_get('upload_max_filesize'),
				2=>App::$l10n->t("The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form"),
				3=>App::$l10n->t("The uploaded file was only partially uploaded"),
				4=>App::$l10n->t("No file was uploaded"),
				6=>App::$l10n->t("Missing a temporary folder")
			);
			$response->bailOut($errors[$error]);
			return $response;
		}

		if(!file_exists($file['tmp_name'])) {
			$response->bailOut('Temporary file: \''.$file['tmp_name'].'\' has gone AWOL?');
			return $response;
		}

		$tmpkey = 'contact-photo-'.md5(basename($file['tmp_name']));
		$image = new \OCP\Image();

		if(!$image->loadFromFile($file['tmp_name'])) {
			$response->bailOut(App::$l10n->t('Couldn\'t load temporary image: ').$file['tmp_name']);
			return $response;
		}

		if(!$image->fixOrientation()) { // No fatal error so we don't bail out.
			$response->debug('Couldn\'t save correct image orientation: '.$tmpkey);
		}

		if($image->valid()) {
			if($image->height() > $maxSize || $image->width() > $maxSize) {
				$image->resize($maxSize);
			}
		} else {
			$response->bailOut(App::$l10n->t('Uploaded image is invalid'));
		}

		if(!$this->server->getCache()->set($tmpkey, $image->data(), 600)) {
			$response->bailOut(App::$l10n->t('Couldn\'t save temporary image: ').$tmpkey);
			return $response;
		}

		$response->setData(array(
			'status' => 'success',
			'data' => array(
				'tmp'=>$tmpkey,
				'metadata' => array(
					'contactId'=> $params['contactId'],
					'addressBookId'=> $params['addressBookId'],
					'backend'=> $params['backend'],
				),
			)
		));

		return $response;
	}

	/**
	 * Saves the photo from the contact being edited to oC cache
	 * @return JSONResponse with data.tmp set to the key in the cache.
	 *
	 * @NoAdminRequired
	 * @NoCSRFRequired
	 */
	public function cacheCurrentPhoto() {
		$params = $this->request->urlParams;
		$response = new JSONResponse();
		$maxSize = isset($this->request->get['maxSize']) ? $this->request->get['maxSize'] : 400;

		$photoResponse = $this->getPhoto($maxSize);

		if(!$photoResponse instanceof ImageResponse) {
			return $photoResponse;
		}

		$data = $photoResponse->render();
		$tmpkey = 'contact-photo-' . $params['contactId'];
		if(!$this->server->getCache()->set($tmpkey, $data, 600)) {
			$response->bailOut(App::$l10n->t('Couldn\'t save temporary image: ').$tmpkey);
			return $response;
		}

		$response->setParams(array(
			'tmp'=>$tmpkey,
			'metadata' => array(
				'contactId'=> $params['contactId'],
				'addressBookId'=> $params['addressBookId'],
				'backend'=> $params['backend'],
			),
		));

		return $response;

	}

	/**
	 * Saves the photo from ownCloud FS to oC cache
	 * @return JSONResponse with data.tmp set to the key in the cache.
	 *
	 * @NoAdminRequired
	 * @NoCSRFRequired
	 */
	public function cacheFileSystemPhoto() {
		$params = $this->request->urlParams;
		$maxSize = isset($this->request->get['maxSize']) ? $this->request->get['maxSize'] : 400;
		$response = new JSONResponse();

		if(!isset($this->request->get['path'])) {
			$response->bailOut(App::$l10n->t('No photo path was submitted.'));
		}

		$localpath = \OC\Files\Filesystem::getLocalFile($this->request->get['path']);
		$tmpkey = 'contact-photo-' . $params['contactId'];

		if(!file_exists($localpath)) {
			return $response->bailOut(App::$l10n->t('File doesn\'t exist:').$localpath);
		}

		$image = new \OCP\Image();
		if(!$image) {
			return $response->bailOut(App::$l10n->t('Error loading image.'));
		}
		if(!$image->loadFromFile($localpath)) {
			return $response->bailOut(App::$l10n->t('Error loading image.'));
		}
		if($image->width() > $maxSize || $image->height() > $maxSize) {
			$image->resize($maxSize); // Prettier resizing than with browser and saves bandwidth.
		}
		if(!$image->fixOrientation()) { // No fatal error so we don't bail out.
			$response->debug('Couldn\'t save correct image orientation: '.$localpath);
		}
		if(!$this->server->getCache()->set($tmpkey, $image->data(), 600)) {
			return $response->bailOut('Couldn\'t save temporary image: '.$tmpkey);
		}

		return $response->setData(array(
			'tmp'=>$tmpkey,
			'metadata' => array(
				'contactId'=> $params['contactId'],
				'addressBookId'=> $params['addressBookId'],
				'backend'=> $params['backend'],
			),
		));

	}

	/**
	 * Get a photo from the oC cache for cropping.
	 * @NoAdminRequired
	 * @NoCSRFRequired
	 */
	public function getTempPhoto() {
		$params = $this->request->urlParams;
		$tmpkey = $params['key'];

		$image = new \OCP\Image();
		$image->loadFromData($this->server->getCache()->get($tmpkey));
		if($image->valid()) {
			$response = new ImageResponse($image);
			return $response;
		} else {
			$response = new JSONResponse();
			return $response->bailOut('Error getting temporary photo');
		}
	}

	/**
	 * Get a photo from the oC and crops it with the suplied geometry.
	 * @NoAdminRequired
	 * @NoCSRFRequired
	 */
	public function cropPhoto() {
		$params = $this->request->urlParams;
		$x = (isset($this->request->post['x']) && $this->request->post['x']) ? $this->request->post['x'] : 0;
		$y = (isset($this->request->post['y']) && $this->request->post['y']) ? $this->request->post['y'] : 0;
		$w = (isset($this->request->post['w']) && $this->request->post['w']) ? $this->request->post['w'] : -1;
		$h = (isset($this->request->post['h']) && $this->request->post['h']) ? $this->request->post['h'] : -1;
		$tmpkey = $params['key'];

		$app = new App($this->api->getUserId());
		$addressBook = $app->getAddressBook($params['backend'], $params['addressBookId']);
		$contact = $addressBook->getChild($params['contactId']);

		$response = new JSONResponse();

		if(!$contact) {
			return $response->bailOut(App::$l10n->t('Couldn\'t find contact.'));
		}

		$data = $this->server->getCache()->get($tmpkey);
		if(!$data) {
			return $response->bailOut(App::$l10n->t('Image has been removed from cache'));
		}

		$image = new \OCP\Image();

		if(!$image->loadFromData($data)) {
			return $response->bailOut(App::$l10n->t('Error creating temporary image'));
		}

		$w = ($w !== -1 ? $w : $image->width());
		$h = ($h !== -1 ? $h : $image->height());

		if(!$image->crop($x, $y, $w, $h)) {
			return $response->bailOut(App::$l10n->t('Error cropping image'));
		}

		// For vCard 3.0 the type must be e.g. JPEG or PNG
		// For version 4.0 the full mimetype should be used.
		// https://tools.ietf.org/html/rfc2426#section-3.1.4
		if(strval($contact->VERSION) === '4.0') {
			$type = $image->mimeType();
		} else {
			$type = explode('/', $image->mimeType());
			$type = strtoupper(array_pop($type));
		}
		if(isset($contact->PHOTO)) {
			$property = $contact->PHOTO;
			if(!$property) {
				$this->server->getCache()->remove($tmpkey);
				return $response->bailOut(App::$l10n
					->t('Error getting PHOTO property.'));
			}
			$property->setValue(strval($image));
			$property->parameters = array();
			$property->parameters[]
				= new \Sabre\VObject\Parameter('ENCODING', 'b');
			$property->parameters[]
				= new \Sabre\VObject\Parameter('TYPE', $image->mimeType());
			$contact->PHOTO = $property;
		} else {
			$contact->add('PHOTO',
				strval($image), array('ENCODING' => 'b',
				'TYPE' => $type));
			// TODO: Fix this hack
			$contact->setSaved(false);
		}
		if(!$contact->save()) {
			return $response->bailOut(App::$l10n->t('Error saving contact.'));
		}

		$thumbnail = Properties::cacheThumbnail(
			$params['backend'],
			$params['addressBookId'],
			$params['contactId'],
			$image
		);

		$response->setData(array(
			'status' => 'success',
			'data' => array(
				'id' => $params['contactId'],
				'thumbnail' => $thumbnail,
			)
		));

		$this->server->getCache()->remove($tmpkey);

		return $response;
	}

}