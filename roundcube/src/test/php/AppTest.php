<?php

//namespace OCA\roundcube;

//OC_App::loadApp('roundcube');
require_once 'mocks_oc.php';
require_once 'mocks_ocp.php';
require_once("appinfo/app.php");

/**
 * Simple Unit test which checks the PHP syntax of all used files in the app
 * @author mreinhardt
 *
*/
class AppTest extends PHPUnit_Framework_TestCase {

	/**
	 * Start http server instance in background.
	 * @return Mock_Http_Server
	 *
	public function start()
	{
		shell_exec('cd '.$this->getBinDir().';nohup ./httpd -p '.$this->getPort().' -w '.$this->getWebDir().' -P '.$this->getPidFile().' > /dev/null 2>&1 < /dev/null &');
		usleep(300000);
		return $this;
	}
	*/
	protected function setUp() {
	}

	public function testApp(){

	}
}

