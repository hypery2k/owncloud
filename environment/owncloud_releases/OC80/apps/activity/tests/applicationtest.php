<?php

/**
 * ownCloud - Activity App
 *
 * @author Joas Schilling
 * @copyright 2014 Joas Schilling nickvergessen@owncloud.com
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU AFFERO GENERAL PUBLIC LICENSE
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU AFFERO GENERAL PUBLIC LICENSE for more details.
 *
 * You should have received a copy of the GNU Affero General Public
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace OCA\Activity\Tests;

use OCA\Activity\AppInfo\Application;

class ApplicationTest extends TestCase {
	/** @var \OCA\Activity\AppInfo\Application */
	protected $app;

	/** @var \OCP\AppFramework\IAppContainer */
	protected $container;

	protected function setUp() {
		parent::setUp();
		$this->app = new Application();
		$this->container = $this->app->getContainer();
	}

	public function testContainerAppName() {
		$this->app = new Application();
		$this->assertEquals('activity', $this->container->getAppName());
	}

	public function queryData() {
		return array(
			array('ActivityData', 'OCA\Activity\Data'),
			array('ActivityL10N', 'OCP\IL10N'),
			array('Consumer', 'OCA\Activity\Consumer'),
			array('Consumer', 'OCP\Activity\IConsumer'),
			array('DataHelper', 'OCA\Activity\DataHelper'),
			array('GroupHelper', 'OCA\Activity\GroupHelper'),
			array('Hooks', 'OCA\Activity\Hooks'),
			array('Navigation', 'OCA\Activity\Navigation'),
			array('UserSettings', 'OCA\Activity\UserSettings'),
			array('URLGenerator', 'OCP\IURLGenerator'),
			array('SettingsController', 'OCP\AppFramework\Controller'),
			array('ActivitiesController', 'OCP\AppFramework\Controller'),
		);
	}

	/**
	 * @dataProvider queryData
	 * @param string $service
	 * @param string $expected
	 */
	public function testContainerQuery($service, $expected) {
		$this->assertTrue($this->container->query($service) instanceof $expected);
	}
}
