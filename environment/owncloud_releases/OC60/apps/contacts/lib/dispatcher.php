<?php
/**
 * Copyright (c) 2013 Thomas Tanghus (thomas@tanghus.net)
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

namespace OCA\Contacts;

use OCP\AppFramework\App as MainApp,
	OCP\AppFramework\IAppContainer,
	OCA\Contacts\App,
	OCA\Contacts\Middleware\Http as HttpMiddleware,
	OCA\Contacts\Controller\PageController,
	OCA\Contacts\Controller\AddressBookController,
	OCA\Contacts\Controller\GroupController,
	OCA\Contacts\Controller\ContactController,
	OCA\Contacts\Controller\ContactPhotoController,
	OCA\Contacts\Controller\SettingsController,
	OCA\Contacts\Controller\ImportController,
	OCA\Contacts\Controller\ExportController;

/**
 * This class manages our app actions
 *
 * TODO: Merge with App
 */

class Dispatcher extends MainApp {
	/**
	* @var App
	*/
	protected $app;

	public function __construct($params) {
		parent::__construct('contacts', $params);
		$this->container = $this->getContainer();
		$this->app = new App($this->container->query('API')->getUserId());
		$this->registerServices();
		$this->container->registerMiddleware('HttpMiddleware');
	}


	public function registerServices() {
		$app = $this->app;
		$this->container->registerService('HttpMiddleware', function(IAppContainer $container) use($app) {
			return new HttpMiddleware($container);
		});
		$this->container->registerService('PageController', function(IAppContainer $container) use($app) {
			return new PageController($container, $app);
		});
		$this->container->registerService('AddressBookController', function(IAppContainer $container) use($app) {
			return new AddressBookController($container, $app);
		});
		$this->container->registerService('GroupController', function(IAppContainer $container) use($app) {
			return new GroupController($container, $app);
		});
		$this->container->registerService('ContactController', function(IAppContainer $container) use($app) {
			return new ContactController($container, $app);
		});
		$this->container->registerService('ContactPhotoController', function(IAppContainer $container) use($app) {
			return new ContactPhotoController($container, $app);
		});
		$this->container->registerService('SettingsController', function(IAppContainer $container) use($app) {
			return new SettingsController($container, $app);
		});
		$this->container->registerService('ImportController', function(IAppContainer $container) use($app) {
			return new ImportController($container, $app);
		});
		$this->container->registerService('ExportController', function(IAppContainer $container) use($app) {
			return new ExportController($container, $app);
		});
	}

}
