<?php

/**
 * ownCloud
 *
 * @author Joas Schilling
 * @copyright 2014 Joas Schilling nickvergessen@owncloud.com
 *
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

namespace OCA\Activity\Tests\Controller;

use OCA\Activity\Controller\Settings;
use OCA\Activity\Tests\TestCase;

class SettingsTest extends TestCase {
	/** @var \PHPUnit_Framework_MockObject_MockObject */
	protected $config;

	/** @var \PHPUnit_Framework_MockObject_MockObject */
	protected $request;

	/** @var \PHPUnit_Framework_MockObject_MockObject */
	protected $urlGenerator;

	/** @var \PHPUnit_Framework_MockObject_MockObject */
	protected $data;

	/** @var \PHPUnit_Framework_MockObject_MockObject */
	protected $random;

	/** @var \PHPUnit_Framework_MockObject_MockObject */
	protected $userSettings;

	/** @var \OCP\IL10N */
	protected $l10n;

	/** @var Settings */
	protected $controller;

	protected function setUp() {
		parent::setUp();

		$this->data = $this->getMockBuilder('OCA\Activity\Data')
			->disableOriginalConstructor()
			->getMock();
		$this->userSettings = $this->getMockBuilder('OCA\Activity\UserSettings')
			->disableOriginalConstructor()
			->getMock();

		$this->config = $this->getMock('OCP\IConfig');
		$this->request = $this->getMock('OCP\IRequest');
		$this->urlGenerator = $this->getMock('OCP\IURLGenerator');
		$this->random = $this->getMock('OCP\Security\ISecureRandom');
		$this->l10n = \OCP\Util::getL10N('activity', 'en');

		$this->controller = new Settings(
			'activity',
			$this->request,
			$this->config,
			$this->random,
			$this->urlGenerator,
			$this->data,
			$this->userSettings,
			$this->l10n,
			'test'
		);
	}


	public function personalNonTypeSettingsData() {
		return [
			[3600, false, false, 0, false, false],
			[3600 * 24, true, false, 1, true, false],
			[3600 * 24 * 7, false, true, 2, false, true],
		];
	}

	/**
	 * @dataProvider personalNonTypeSettingsData
	 *
	 * @param int $expectedBatchTime
	 * @param bool $notifyEmail
	 * @param bool $notifyStream
	 * @param int $notifySettingBatchTime
	 * @param bool $notifySettingSelf
	 * @param bool $notifySettingSelfEmail
	 */
	public function testPersonalNonTypeSettings($expectedBatchTime, $notifyEmail, $notifyStream, $notifySettingBatchTime, $notifySettingSelf, $notifySettingSelfEmail) {
		$this->data->expects($this->any())
			->method('getNotificationTypes')
			->willReturn(['NotificationTestTypeShared' => 'Share description']);

		$this->request->expects($this->any())
			->method('getParam')
			->willReturnMap([
				['NotificationTestTypeShared_email', false, $notifyEmail],
				['NotificationTestTypeShared_stream', false, $notifyStream],
			]);

		$this->config->expects($this->exactly(5))
			->method('setUserValue');
		$this->config->expects($this->at(0))
			->method('setUserValue')
			->with(
				'test',
				'activity',
				'notify_email_NotificationTestTypeShared',
				$notifyEmail
			);
		$this->config->expects($this->at(1))
			->method('setUserValue')
			->with(
				'test',
				'activity',
				'notify_stream_NotificationTestTypeShared',
				$notifyStream
			);
		$this->config->expects($this->at(2))
			->method('setUserValue')
			->with(
				'test',
				'activity',
				'notify_setting_batchtime',
				$expectedBatchTime
			);
		$this->config->expects($this->at(3))
			->method('setUserValue')
			->with(
				'test',
				'activity',
				'notify_setting_self',
				$notifySettingSelf
			);
		$this->config->expects($this->at(4))
			->method('setUserValue')
			->with(
				'test',
				'activity',
				'notify_setting_selfemail',
				$notifySettingSelfEmail
			);

		$response = $this->controller->personal(
			$notifySettingBatchTime,
			$notifySettingSelf,
			$notifySettingSelfEmail
		)->getData();
		$this->assertDataResponse($response);
	}

	/**
	 * @param array $response
	 */
	protected function assertDataResponse($response) {
		$this->assertEquals(2, sizeof($response));
		$this->assertArrayHasKey('status', $response);
		$this->assertArrayHasKey('data', $response);
		$data = $response['data'];
		$this->assertEquals(1, sizeof($data));
		$this->assertArrayHasKey('message', $data);
		$this->assertEquals('Your settings have been updated.', $data['message']);
	}

	public function testDisplayPanelTypeTable() {
		$this->data->expects($this->any())
			->method('getNotificationTypes')
			->willReturn(['NotificationTestTypeShared' => 'Share description']);

		$renderedResponse = $this->controller->displayPanel()->render();
		$this->assertContains('<form id="activity_notifications" class="section">', $renderedResponse);

		// Checkboxes for the type
		$this->assertContains('<label for="NotificationTestTypeShared_email">', $renderedResponse);
		$this->assertContains('<label for="NotificationTestTypeShared_stream">', $renderedResponse);

		// Description of the type
		$cleanedResponse = str_replace(["\n", "\t"], '', $renderedResponse);
		$this->assertContains('<td class="activity_select_group" data-select-group="NotificationTestTypeShared">Share description</td>', $cleanedResponse);
	}

	public function displayPanelEmailWarningData() {
		return [
			['', true],
			['test@localhost', false],
		];
	}

	/**
	 * @dataProvider displayPanelEmailWarningData
	 *
	 * @param string $email
	 * @param bool $containsWarning
	 */
	public function testDisplayPanelEmailWarning($email, $containsWarning) {
		$this->data->expects($this->any())
			->method('getNotificationTypes')
			->willReturn([]);
		$this->config->expects($this->any())
			->method('getUserValue')
			->willReturn($email);

		$renderedResponse = $this->controller->displayPanel()->render();
		$this->assertContains('<form id="activity_notifications" class="section">', $renderedResponse);

		if ($containsWarning) {
			$this->assertContains('You need to set up your email address before you can receive notification emails.', $renderedResponse);
		} else {
			$this->assertNotContains('You need to set up your email address before you can receive notification emails.', $renderedResponse);
		}
	}

	public function displayPanelEmailSendBatchSettingData() {
		return [
			[0, 0, 'Hourly'],
			['foobar', 0, 'Hourly'],
			[3600, 0, 'Hourly'],
			[3600 * 24, 1, 'Daily'],
			[3600 * 24 * 7, 2, 'Weekly'],
		];
	}

	/**
	 * @dataProvider displayPanelEmailSendBatchSettingData
	 *
	 * @param string $setting
	 * @param int $selectedValue
	 * @param string $selectedLabel
	 */
	public function testDisplayPanelEmailSendBatchSetting($setting, $selectedValue, $selectedLabel) {
		$this->data->expects($this->any())
			->method('getNotificationTypes')
			->willReturn([]);
		$this->userSettings->expects($this->any())
			->method('getUserSetting')
			->willReturn($setting);

		$renderedResponse = $this->controller->displayPanel()->render();
		$this->assertContains('<form id="activity_notifications" class="section">', $renderedResponse);

		$this->assertContains('<option value="' . $selectedValue . '" selected="selected">' . $selectedLabel . '</option>', $renderedResponse);
	}

	public function feedData() {
		return [
			['true', '012345678901234567890123456789', 'feedurl::'],
			['false', '', ''],
		];
	}

	/**
	 * @dataProvider feedData
	 *
	 * @param string $enabled
	 * @param string $token
	 * @param string $urlPrefix
	 */
	public function testFeed($enabled, $token, $urlPrefix) {
		$this->data->expects($this->any())
			->method('getNotificationTypes')
			->willReturn([]);
		$this->random->expects($this->any())
			->method('generate')
			->with(30)
			->willReturn('012345678901234567890123456789');
		$this->urlGenerator->expects($this->any())
			->method('linkToRouteAbsolute')
			->with('activity.rss', ['token' => '012345678901234567890123456789'])
			->willReturn('feedurl::012345678901234567890123456789');
		$this->config->expects($this->once())
			->method('setUserValue')
			->with('test', 'activity', 'rsstoken', $token);

		$response = $this->controller->feed($enabled)->getData();
		$this->assertEquals(2, sizeof($response));
		$this->assertArrayHasKey('status', $response);
		$this->assertArrayHasKey('data', $response);
		$data = $response['data'];
		$this->assertEquals(2, sizeof($data));
		$this->assertArrayHasKey('message', $data);
		$this->assertArrayHasKey('rsslink', $data);

		$this->assertEquals($urlPrefix . $token, $data['rsslink']);
		$this->assertEquals('Your settings have been updated.', $data['message']);
	}
}
