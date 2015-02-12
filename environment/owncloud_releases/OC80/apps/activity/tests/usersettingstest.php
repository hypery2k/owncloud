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

use OC\ActivityManager;
use OCA\Activity\UserSettings;
use OCA\Activity\Data;

class UserSettingsTest extends TestCase {
	/** @var UserSettings */
	protected $userSettings;

	/** @var \PHPUnit_Framework_MockObject_MockObject */
	protected $config;

	protected function setUp() {
		parent::setUp();

		$am = new ActivityManager();
		$this->config = $this->getMock('OCP\IConfig');
		$this->userSettings = new UserSettings($am, $this->config, new Data($am));
	}

	protected function tearDown() {
		parent::tearDown();
	}

	public function getDefaultSettingData() {
		return array(
			array('stream', Data::TYPE_SHARED, true),
			array('stream', Data::TYPE_SHARE_CREATED, true),
			array('email', Data::TYPE_SHARED, true),
			array('email', Data::TYPE_SHARE_CREATED, false),
			array('setting', 'self', true),
			array('setting', 'selfemail', false),
			array('setting', 'batchtime', 3600),
			array('setting', 'not-exists', false),
		);
	}

	/**
	 * @dataProvider getDefaultSettingData
	 *
	 * @param string $method
	 * @param string $type
	 * @param mixed $expected
	 */
	public function testGetDefaultSetting($method, $type, $expected) {
		$this->assertEquals($expected, $this->userSettings->getDefaultSetting($method, $type));
	}

	public function getNotificationTypesData() {
		return array(
			array('test1', 'stream', array('shared', 'file_created', 'file_changed', 'file_deleted', 'file_restored')),
			array('noPreferences', 'email', array('shared')),
		);
	}

	/**
	 * @dataProvider getNotificationTypesData
	 *
	 * @param string $user
	 * @param string $method
	 * @param array $expected
	 */
	public function testGetNotificationTypes($user, $method, $expected) {
		$this->config->expects($this->any())
			->method('getUserValue')
			->with($this->anything(), 'activity', $this->stringStartsWith('notify_'), $this->anything())
			->willReturnMap([
				['test1', 'activity', 'notify_stream_shared', true, true],
				['test1', 'activity', 'notify_stream_file_created', true, true],
				['test1', 'activity', 'notify_stream_file_changed', true, true],
				['test1', 'activity', 'notify_stream_file_deleted', true, true],
				['test1', 'activity', 'notify_stream_file_restored', true, true],
				['noPreferences', 'activity', 'notify_email_shared', true, true],
			]);

		$this->assertEquals($expected, $this->userSettings->getNotificationTypes($user, $method));
	}

	public function filterUsersBySettingData() {
		return array(
			array(array(), 'stream', 'type1', array()),
			array(array('test', 'test1', 'test2', 'test3', 'test4'), 'stream', 'type1', array('test1' => true, 'test4' => true)),
			array(array('test', 'test1', 'test2', 'test3', 'test4', 'test5'), 'email', 'type1', array('test1' => '1', 'test4' => '4', 'test5' => true)),
			array(array('test', 'test6'), 'stream', 'file_created', array('test' => true, 'test6' => true)),
			array(array('test', 'test6'), 'stream', 'file_nodefault', array('test6' => true)),
			array(array('test6'), 'email', 'shared', array('test6' => '2700')),
			array(array('test', 'test6'), 'email', 'shared', array('test' => '3600', 'test6' => '2700')),
			array(array('test', 'test6'), 'email', 'file_created', array('test6' => '2700')),
		);
	}

	/**
	 * @dataProvider filterUsersBySettingData
	 *
	 * @param array $users
	 * @param string $method
	 * @param string $type
	 * @param array $expected
	 */
	public function testFilterUsersBySetting($users, $method, $type, $expected) {
		$this->config->expects($this->any())
			->method('getUserValueForUsers')
			->with($this->anything(), $this->anything(), $this->anything())
			->willReturnMap([
				['activity', 'notify_stream_file_created', ['test', 'test6'], ['test6' => '1']],
				['activity', 'notify_stream_file_nodefault', ['test', 'test6'], ['test6' => '1']],
				['activity', 'notify_stream_type1', ['test', 'test1', 'test2', 'test3', 'test4'], ['test1' => '1', 'test2' => '0', 'test3' => '', 'test4' => '1']],

				['activity', 'notify_email_file_created', ['test', 'test6'], ['test6' => '1']],
				['activity', 'notify_email_shared', ['test6'], ['test6' => '1']],
				['activity', 'notify_email_shared', ['test', 'test6'], ['test6' => '1']],
				['activity', 'notify_email_type1', ['test', 'test1', 'test2', 'test3', 'test4', 'test5'], ['test1' => '1', 'test2' => '0', 'test3' => '', 'test4' => '3', 'test5' => '1']],

				['activity', 'notify_setting_batchtime', ['test6'], ['test6' => '2700']],
				['activity', 'notify_setting_batchtime', ['test', 'test6'], ['test6' => '2700']],
				['activity', 'notify_setting_batchtime', ['test1', 'test4', 'test5'], ['test1' => '1', 'test4' => '4']],
			]);

		$this->assertEquals($expected, $this->userSettings->filterUsersBySetting($users, $method, $type));
	}
}
