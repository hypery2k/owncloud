<?php
/**
 * Copyright (c) 2012, 2013 Thomas Tanghus <thomas@tanghus.net>
 * Copyright (c) 2011 Jakob Sack mail@jakobsack.de
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

namespace OCA\Contacts\Controller;

use OCA\Contacts\App,
	OCA\Contacts\Controller,
	OCA\Contacts\Utils\Properties,
	OCP\AppFramework\Http\TemplateResponse;


/**
 * Controller class for groups/categories
 */
class PageController extends Controller {

	/**
	 * @NoAdminRequired
	 * @NoCSRFRequired
	 */
	public function index() {
		\OC::$server->getNavigationManager()->setActiveEntry('contacts');

		$impp_types = Properties::getTypesForProperty('IMPP');
		$adr_types = Properties::getTypesForProperty('ADR');
		$phone_types = Properties::getTypesForProperty('TEL');
		$email_types = Properties::getTypesForProperty('EMAIL');
		$ims = Properties::getIMOptions();
		$im_protocols = array();
		foreach($ims as $name => $values) {
			$im_protocols[$name] = $values['displayname'];
		}

		$maxUploadFilesize = \OCP\Util::maxUploadFilesize('/');

		\OCP\Util::addScript('', 'jquery.multiselect');
		\OCP\Util::addScript('', 'tags');
		\OCP\Util::addScript('contacts', 'jquery.combobox');
		\OCP\Util::addScript('contacts', 'modernizr.custom');
		\OCP\Util::addScript('contacts', 'app');
		\OCP\Util::addScript('contacts', 'addressbooks');
		\OCP\Util::addScript('contacts', 'contacts');
		\OCP\Util::addScript('contacts', 'storage');
		\OCP\Util::addScript('contacts', 'groups');
		\OCP\Util::addScript('contacts', 'jquery.ocaddnew');
		\OCP\Util::addScript('files', 'jquery.fileupload');
		\OCP\Util::addScript('3rdparty/Jcrop', 'jquery.Jcrop');
		\OCP\Util::addStyle('3rdparty/fontawesome', 'font-awesome');
		\OCP\Util::addStyle('contacts', 'font-awesome');
		\OCP\Util::addStyle('', 'jquery.multiselect');
		\OCP\Util::addStyle('contacts', 'jquery.combobox');
		\OCP\Util::addStyle('contacts', 'jquery.ocaddnew');
		\OCP\Util::addStyle('3rdparty/Jcrop', 'jquery.Jcrop');
		\OCP\Util::addStyle('contacts', 'contacts');

		$response = new TemplateResponse('contacts', 'contacts');
		$response->setParams(array(
			'uploadMaxFilesize' => $maxUploadFilesize,
			'uploadMaxHumanFilesize' => \OCP\Util::humanFileSize($maxUploadFilesize),
			'phone_types' => $phone_types,
			'email_types' => $email_types,
			'adr_types' => $adr_types,
			'impp_types' => $impp_types,
			'im_protocols' => $im_protocols,
		));

		return $response;
	}
}
