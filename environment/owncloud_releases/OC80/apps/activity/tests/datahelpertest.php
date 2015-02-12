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

use OC\Files\View;
use OCA\Activity\DataHelper;
use OCA\Activity\ParameterHelper;
use OCP\Util;

class DataHelperTest extends TestCase {
	protected $originalWEBROOT;

	protected function setUp() {
		parent::setUp();

		$this->originalWEBROOT =\OC::$WEBROOT;
		\OC::$WEBROOT = '';
	}

	protected function tearDown() {
		\OC::$WEBROOT = $this->originalWEBROOT;
		parent::tearDown();
	}

	public function translationData() {
		return array(
			array(
				'created_self', array('/SubFolder/A.txt'), false, false,
				'You created SubFolder/A.txt',
			),
			array(
				'created_self', array('/SubFolder/A.txt'), true, false,
				'You created A.txt',
			),
			array(
				'created_self', array('/SubFolder/A.txt'), false, true,
				'You created <a class="filename" href="/index.php/apps/files?dir=%2FSubFolder&scrollto=A.txt">SubFolder/A.txt</a>',
			),
			array(
				'created_self', array('/SubFolder/A.txt'), true, true,
				'You created <a class="filename tooltip" href="/index.php/apps/files?dir=%2FSubFolder&scrollto=A.txt" title="in SubFolder">A.txt</a>',
			),

			array('created_by', array('/SubFolder/A.txt', 'UserB'), false, false, 'UserB created SubFolder/A.txt'),
			array('created_by', array('/SubFolder/A.txt', 'UserB'), true, false, 'UserB created A.txt'),
			array(
				'created_by', array('/SubFolder/A.txt', 'UserB'), false, true,
				'<div class="avatar" data-user="UserB"></div><strong>UserB</strong> created '
				. '<a class="filename" href="/index.php/apps/files?dir=%2FSubFolder&scrollto=A.txt">SubFolder/A.txt</a>',
			),
			array(
				'created_by', array('/SubFolder/A.txt', 'UserB'), true, true,
				'<div class="avatar" data-user="UserB"></div><strong>UserB</strong> created '
				. '<a class="filename tooltip" href="/index.php/apps/files?dir=%2FSubFolder&scrollto=A.txt" title="in SubFolder">A.txt</a>',
			),
			array(
				'created_by', array('/A.txt', 'UserB'), true, true,
				'<div class="avatar" data-user="UserB"></div><strong>UserB</strong> created '
				. '<a class="filename" href="/index.php/apps/files?dir=%2F&scrollto=A.txt">A.txt</a>',
			),

			array(
				'created_self',
				array(array('/SubFolder/A.txt')),
				false,
				false,
				'You created SubFolder/A.txt',
			),
			array(
				'created_self',
				array(array('/SubFolder/A.txt', '/SubFolder/B.txt')),
				false,
				false,
				'You created SubFolder/A.txt and SubFolder/B.txt',
			),
			array(
				'created_self',
				array(array('/SubFolder/A.txt', '/SubFolder/B.txt', '/SubFolder/C.txt', '/SubFolder/D.txt', '/SubFolder/E.txt')),
				false,
				false,
				'You created SubFolder/A.txt, SubFolder/B.txt, SubFolder/C.txt, SubFolder/D.txt and SubFolder/E.txt',
			),
			array(
				'created_self',
				array(array('/SubFolder/A.txt', '/SubFolder/B.txt', '/SubFolder/C.txt', '/SubFolder/D.txt', '/SubFolder/E.txt', '/SubFolder/F.txt')),
				false,
				false,
				'You created SubFolder/A.txt, SubFolder/B.txt, SubFolder/C.txt and 3 more',
			),
			array(
				'created_self',
				array(array('/SubFolder/A.txt', '/SubFolder/B.txt', '/SubFolder/C.txt', '/SubFolder/D.txt', '/SubFolder/E.txt', '/SubFolder/F.txt')),
				true,
				false,
				'You created A.txt, B.txt, C.txt and 3 more',
			),
			array(
				'created_self',
				array(array('/SubFolder/A.txt', '/SubFolder/B.txt', '/SubFolder/C.txt', '/SubFolder/D.txt', '/SubFolder/E.txt', '/SubFolder/F.txt')),
				false,
				true,
				'You created <a class="filename" href="/index.php/apps/files?dir=%2FSubFolder&scrollto=A.txt">SubFolder/A.txt</a>,'
				. ' <a class="filename" href="/index.php/apps/files?dir=%2FSubFolder&scrollto=B.txt">SubFolder/B.txt</a>,'
				. ' <a class="filename" href="/index.php/apps/files?dir=%2FSubFolder&scrollto=C.txt">SubFolder/C.txt</a>'
				. ' and <strong class="tooltip" title="SubFolder/D.txt, SubFolder/E.txt, SubFolder/F.txt">3 more</strong>',
			),

			['created_public', ['/SubFolder/A.txt'], true, false, 'A.txt was created in a public folder'],
			['changed_self', ['/SubFolder/A.txt'], true, false, 'You changed A.txt'],
			['changed_by', ['/SubFolder/A.txt', 'UserB'], true, false, 'UserB changed A.txt'],
			['deleted_self', ['/SubFolder/A.txt'], true, false, 'You deleted A.txt'],
			['deleted_by', ['/SubFolder/A.txt', 'UserB'], true, false, 'UserB deleted A.txt'],
			['restored_self', ['/SubFolder/A.txt'], true, false, 'You restored A.txt'],
			['restored_by', ['/SubFolder/A.txt', 'UserB'], true, false, 'UserB restored A.txt'],
			['shared_user_self', ['/SubFolder/A.txt', 'UserB'], true, false, 'You shared A.txt with UserB'],
			['shared_group_self', ['/SubFolder/A.txt', 'GroupC'], true, false, 'You shared A.txt with group GroupC'],
			['shared_with_by', ['/SubFolder/A.txt', 'UserB'], true, false, 'UserB shared A.txt with you'],
		);
	}

	/**
	 * @dataProvider translationData
	 */
	public function testTranslation($text, $params, $stripPath, $highlightParams, $expected) {
		$dataHelper = new DataHelper(
			$this->getMock('\OCP\Activity\IManager'),
			new ParameterHelper(
				$this->getMock('\OCP\Activity\IManager'),
				new View(''),
				Util::getL10N('activity')
			),
			Util::getL10N('activity')
		);

		$this->assertEquals(
			$expected,
			(string) $dataHelper->translation('files', $text, $params, $stripPath, $highlightParams)
		);
	}

	public function translationNotActivityAppData() {
		return array(
			array(
				'You created %1$s', array('/SubFolder/A.txt'), false, false,
				'You created /SubFolder/A.txt',
			),
			array(
				'You created %1$s', array('/SubFolder/A.txt'), true, false,
				'You created /SubFolder/A.txt',
			),
			array(
				'You created %1$s', array('/SubFolder/A.txt'), false, true,
				'You created <strong>/SubFolder/A.txt</strong>',
			),
			array(
				'You created %1$s', array('/SubFolder/A.txt'), true, true,
				'You created <strong>/SubFolder/A.txt</strong>',
			),
		);
	}


	/**
	 * @dataProvider translationNotActivityAppData
	 */
	public function testTranslationNotActivityApp($text, $params, $stripPath, $highlightParams, $expected) {
		$manager = $this->getMock('\OCP\Activity\IManager');
		$manager->expects($this->any())
			->method('translate')
			->willReturn(false);
		$dataHelper = new DataHelper(
			$manager,
			new ParameterHelper(
				$manager,
				new View(''),
				Util::getL10N('activity')
			),
			Util::getL10N('activity')
		);

		$this->assertEquals(
			$expected,
			(string) $dataHelper->translation('activity', $text, $params, $stripPath, $highlightParams)
		);
	}

	public function getTypeIconData() {
		return [
			['file_changed', 'icon-change'],
			['otherApp', ''],
		];
	}


	/**
	 * @dataProvider getTypeIconData
	 */
	public function testGetTypeIcon($type, $expected) {
		$manager = $this->getMock('\OCP\Activity\IManager');
		$manager->expects($this->any())
			->method('getTypeIcon')
			->willReturn('');
		$dataHelper = new DataHelper(
			$manager,
			new ParameterHelper(
				$manager,
				new View(''),
				Util::getL10N('activity')
			),
			Util::getL10N('activity')
		);

		$this->assertEquals($expected, $dataHelper->getTypeIcon($type));
	}
}
