<?php
/**
 * @author Thomas Tanghus
 * Copyright (c) 2013 Thomas Tanghus (thomas@tanghus.net)
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

namespace OCA\Contacts;

use OCP\AppFramework\IAppContainer,
	OCP\AppFramework\Controller as  BaseController,
	OCP\IRequest,
	OCA\Contacts\App;

/**
 * Base Controller class for Contacts App
 */
class Controller extends BaseController {

	/**
	* @var Api
	*/
	protected $api;

	/**
	* @var IRequest
	*/
	protected $request;

	/**
	* @var App
	*/
	protected $app;

	public function __construct(IAppContainer $container, App $app) {
		$this->api = $container->query('API');
		$this->request = $container->query('Request');
		$this->server = $container->getServer();
		$this->app = $app;
	}

}
