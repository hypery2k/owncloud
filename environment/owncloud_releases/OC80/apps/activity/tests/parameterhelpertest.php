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

class ParameterHelperTest extends TestCase {
	/** @var string */
	protected $originalWEBROOT;
	/** @var \OCA\Activity\ParameterHelper */
	protected $parameterHelper;
	/** @var \OC\Files\View */
	protected $view;

	protected function setUp() {
		parent::setUp();

		$this->originalWEBROOT =\OC::$WEBROOT;
		\OC::$WEBROOT = '';
		$l = \OCP\Util::getL10N('activity');
		$this->view = new \OC\Files\View('');
		$manager = $this->getMock('\OCP\Activity\IManager');
		$manager->expects($this->any())
			->method('getSpecialParameterList')
			->will($this->returnValue(false));
		$this->parameterHelper = new \OCA\Activity\ParameterHelper(
			$manager,
			$this->view,
			$l
		);
	}

	protected function tearDown() {
		\OC::$WEBROOT = $this->originalWEBROOT;
		parent::tearDown();
	}

	public function prepareParametersData() {
		return array(
			array(array(), false, false, false, array()),

			// No file position: no path strip
			array(array('/foo/bar.file'), array(), false, false, array('/foo/bar.file')),
			array(array('/foo/bar.file'), array(), true, false, array('/foo/bar.file')),
			array(array('/foo/bar.file'), array(), false, true, array('<strong>/foo/bar.file</strong>')),
			array(array('/foo/bar.file'), array(), true, true, array('<strong>/foo/bar.file</strong>')),

			// Valid file position
			array(array('/foo/bar.file'), array(0 => 'file'), true, false, array('bar.file')),
			array(array('/folder/trailingslash/fromsharing/'), array(0 => 'file'), true, false, array('fromsharing')),
			array(array('/foo/bar.file'), array(0 => 'file'), false, false, array('foo/bar.file')),
			array(array('/folder/trailingslash/fromsharing/'), array(0 => 'file'), false, false, array('folder/trailingslash/fromsharing')),
			array(array('/foo/bar.file'), array(0 => 'file'), true, true, array(
				'<a class="filename tooltip" href="/index.php/apps/files?dir=%2Ffoo&scrollto=bar.file" title="in foo">bar.file</a>',
			)),
			array(array('/0/bar.file'), array(0 => 'file'), true, true, array(
				'<a class="filename tooltip" href="/index.php/apps/files?dir=%2F0&scrollto=bar.file" title="in 0">bar.file</a>',
			)),
			array(array('/foo/bar.file'), array(1 => 'file'), true, false, array('/foo/bar.file')),
			array(array('/foo/bar.file'), array(1 => 'file'), true, true, array('<strong>/foo/bar.file</strong>')),

			// Legacy: stored without leading slash
			array(array('foo/bar.file'), array(0 => 'file'), false, false, array('foo/bar.file')),
			array(array('foo/bar.file'), array(0 => 'file'), false, true, array(
				'<a class="filename" href="/index.php/apps/files?dir=%2Ffoo&scrollto=bar.file">foo/bar.file</a>',
			)),
			array(array('foo/bar.file'), array(0 => 'file'), true, false, array('bar.file')),
			array(array('foo/bar.file'), array(0 => 'file'), true, true, array(
				'<a class="filename tooltip" href="/index.php/apps/files?dir=%2Ffoo&scrollto=bar.file" title="in foo">bar.file</a>',
			)),

			// Valid file position
			array(array('UserA', '/foo/bar.file'), array(1 => 'file'), true, false, array('UserA', 'bar.file')),
			array(array('UserA', '/foo/bar.file'), array(1 => 'file'), true, true, array(
				'<strong>UserA</strong>',
				'<a class="filename tooltip" href="/index.php/apps/files?dir=%2Ffoo&scrollto=bar.file" title="in foo">bar.file</a>',
			)),
			array(array('UserA', '/foo/bar.file'), array(2 => 'file'), true, false, array('UserA', '/foo/bar.file')),
			array(array('UserA', '/foo/bar.file'), array(2 => 'file'), true, true, array(
				'<strong>UserA</strong>',
				'<strong>/foo/bar.file</strong>',
			)),
			array(array('UserA', '/foo/bar.file'), array(0 => 'username'), true, true, array(
				'<div class="avatar" data-user="UserA"></div><strong>UserA</strong>',
				'<strong>/foo/bar.file</strong>',
			)),
			array(array('U<ser>A', '/foo/bar.file'), array(0 => 'username'), true, true, array(
				'<div class="avatar" data-user="U&lt;ser&gt;A"></div><strong>U&lt;ser&gt;A</strong>',
				'<strong>/foo/bar.file</strong>',
			)),
			array(array('', '/foo/bar.file'), array(0 => 'username'), true, true, array(
				'<strong>"remote user"</strong>',
				'<strong>/foo/bar.file</strong>',
			)),
			array(array('', '/foo/bar.file'), array(0 => 'username'), true, false, array(
				'"remote user"',
				'/foo/bar.file',
			)),

			array(array('UserA', '/foo/bar.file'), array(0 => 'username', 1 => 'file'), true, true, array(
				'<div class="avatar" data-user="UserA"></div><strong>UserA</strong>',
				'<a class="filename tooltip" href="/index.php/apps/files?dir=%2Ffoo&scrollto=bar.file" title="in foo">bar.file</a>',
			)),
			array(array('UserA', '/tmp/test'), array(0 => 'username', 1 => 'file'), true, true, array(
				'<div class="avatar" data-user="UserA"></div><strong>UserA</strong>',
				'<a class="filename tooltip" href="/index.php/apps/files?dir=%2Ftmp%2Ftest" title="in tmp">test</a>',
			), 'tmp/test/'),
		);
	}

	/**
	 * @dataProvider prepareParametersData
	 */
	public function testPrepareParameters($params, $filePosition, $stripPath, $highlightParams, $expected, $createFolder = '') {
		if ($createFolder !== '') {
			$this->view->mkdir('/' . \OCP\User::getUser() . '/files/' . $createFolder);
		}
		$this->assertEquals(
			$expected,
			$this->parameterHelper->prepareParameters($params, $filePosition, $stripPath, $highlightParams)
		);
	}

	public function prepareArrayParametersData() {
		return array(
			array(array(), 'file', true, true, ''),
			array(array('A/B.txt', 'C/D.txt'), 'file', true, false, 'B.txt and D.txt'),
			array(array('A/B.txt', 'C/D.txt'), '', true, false, 'A/B.txt and C/D.txt'),
		);
	}

	/**
	 * @dataProvider prepareArrayParametersData
	 */
	public function testPrepareArrayParameters($params, $paramType, $stripPath, $highlightParams, $expected) {
		$this->assertEquals(
			$expected,
			(string) $this->parameterHelper->prepareArrayParameter($params, $paramType, $stripPath, $highlightParams)
		);
	}

	public function getSpecialParameterListData() {
		return array(
			array('files', 'shared_group_self', array(0 => 'file')),
			array('files', 'shared_group', array(0 => 'file', 1 => 'username')),
			array('files', '', array(0 => 'file', 1 => 'username')),
			array('calendar', 'shared_group', array()),
			array('calendar', '', array()),
		);
	}

	/**
	 * @dataProvider getSpecialParameterListData
	 */
	public function testGetSpecialParameterList($app, $text, $expected) {
		$this->assertEquals($expected, $this->parameterHelper->getSpecialParameterList($app, $text));
	}
}
