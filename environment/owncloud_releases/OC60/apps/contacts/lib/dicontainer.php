<?php
/**
 * @author Thomas Tanghus
 * Copyright (c) 2013 Thomas Tanghus (thomas@tanghus.net)
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

namespace OCA\Contacts;

use OCA\AppFramework\DependencyInjection\DIContainer as BaseContainer,
	OCA\AppFramework\Middleware\MiddlewareDispatcher,
	OCA\AppFramework\Middleware\Security\SecurityMiddleware,
	OCA\Contacts\Middleware\Http as HttpMiddleware,
	OCA\Contacts\Controller\AddressBookController,
	OCA\Contacts\Controller\GroupController,
	OCA\Contacts\Controller\ContactController,
	OCA\Contacts\Controller\ContactPhotoController,
	OCA\Contacts\Controller\SettingsController,
	OCA\Contacts\Controller\ImportController;

class DIContainer extends BaseContainer {


	/**
	 * Define your dependencies in here
	 */
	public function __construct(){
		// tell parent container about the app name
		parent::__construct('contacts');

		$this['HttpMiddleware'] = $this->share(function($c){
			return new HttpMiddleware($c['API']);
		});

		$this['MiddlewareDispatcher'] = $this->share(function($c){
			$dispatcher = new MiddlewareDispatcher();
			$dispatcher->registerMiddleware($c['HttpMiddleware']);
			$dispatcher->registerMiddleware($c['SecurityMiddleware']);

			return $dispatcher;
		});

		/**
		 * CONTROLLERS
		 */
		$this['AddressBookController'] = $this->share(function($c){
			return new AddressBookController($c['API'], $c['Request']);
		});

		$this['GroupController'] = $this->share(function($c){
			return new GroupController($c['API'], $c['Request']);
		});

		$this['ContactController'] = $this->share(function($c){
			return new ContactController($c['API'], $c['Request']);
		});

		$this['ContactPhotoController'] = $this->share(function($c){
			return new ContactPhotoController($c['API'], $c['Request']);
		});

		$this['SettingsController'] = $this->share(function($c){
			return new SettingsController($c['API'], $c['Request']);
		});

		$this['ImportController'] = $this->share(function($c){
			return new ImportController($c['API'], $c['Request']);
		});

	}
}