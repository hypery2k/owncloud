<?php

/**
 * Copyright (c) 2014 Victor Dubiniuk <victor.dubiniuk@gmail.com>
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

 class Test_Updater_App extends  \PHPUnit_Framework_TestCase {
	public function testGetFeed(){
		$mockedAppConfig = $this->getMockBuilder('\OC\AppConfig')
				->disableOriginalConstructor()
				->getMock()
		;

		$certificateManager = $this->getMock('\OCP\ICertificateManager');
		$mockedHTTPHelper = $this->getMockBuilder('\OC\HTTPHelper')
				->setConstructorArgs(array(\OC::$server->getConfig(), $certificateManager))
				->getMock()
		;

		$mockedHTTPHelper->expects($this->once())->method('getUrlContent')->will($this->returnValue(''));
		
		$data = OCA\Updater\App::getFeed($mockedHTTPHelper, $mockedAppConfig);
		$this->assertNotNull($data);
	}
 }