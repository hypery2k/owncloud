<?php

require_once 'mocks_oc.php';
require_once 'mocks_ocp.php';
require_once 'mocks_RoundCubeApp.php';
require_once("appinfo/app.php");
require_once("lib/RoundCubeLogin.class.php");
require_once("lib/RoundCubeAuthHelper.class.php");
require_once("lib/MailNetworkingException.class.php");
require_once("lib/MailLoginException.class.php");

/**
 * Simple Unit test which checks the PHP syntax of all used files in the app
 * @author mreinhardt
 *
*/
class OC_RoundCube_App_Test extends PHPUnit_Framework_TestCase {

	protected function setUp() {
		$userRcEntries = array(array(
				'mail_user'  => 'user',
				'mail_password'  => 'password'
		));
		OC_RoundCube_App::$RC_USER_ENTRIES = $userRcEntries;
		OC_RoundCube_App::$DB_USER='user';
		OC_RoundCube_App::$LOGIN_USER='user';
	}

	public function testAuthHelperSuccessAutoLogin(){
		OCP\Config::$APPVALUE = array(
		'autoLogin'	=> true,
		'maildir' 	=> 'mail',
		'rcHost'	=> 'localhost',
		'rcPort'	=> 443
		);
		OC_RoundCube_App::$LOGIN_RESULT = true;
		$params = array(
				"uid" => 'user',
				"password" => 'password',
		);
		$loggedIn=OC_RoundCube_AuthHelper::login($params);
		$this->assertTrue($loggedIn,'Should be logged in');
	}

	public function testAuthHelperSuccessManualLogin(){
		OCP\Config::$APPVALUE = array(
		'autoLogin'	=> true,
		'maildir' 	=> 'mail',
		'rcHost'	=> 'localhost',
		'rcPort'	=> 443
		);
		OC_RoundCube_App::$LOGIN_RESULT = true;
		$params = array(
				"uid" => 'user',
				"password" => 'password',
		);
		$loggedIn=OC_RoundCube_AuthHelper::login($params);
		$this->assertTrue($loggedIn,'Should be logged in');
	}

	public function testAuthHelperUnsuccessfulAutolLogin(){
		OCP\Config::$APPVALUE = array(
		'autoLogin'	=> true,
		'maildir' 	=> 'mail',
		'rcHost'	=> 'localhost',
		'rcPort'	=> 443
		);
		OC_RoundCube_App::$LOGIN_RESULT = false;
		$params = array(
				"uid" => 'user',
				"password" => 'password',
		);
		$loggedIn=OC_RoundCube_AuthHelper::login($params);
		$this->assertFalse($loggedIn,'Should not be logged in');
	}

	public function testAuthHelperUnsuccessfullManualLogin(){
		OCP\Config::$APPVALUE = array(
		'autoLogin'	=> false,
		'maildir' 	=> 'mail',
		'rcHost'	=> 'localhost',
		'rcPort'	=> 443
		);
		OC_RoundCube_App::$LOGIN_RESULT = false;
		$params = array(
				"uid" => 'user',
				"password" => 'password',
		);
		$loggedIn=OC_RoundCube_AuthHelper::login($params);
		$this->assertFalse($loggedIn,'Should not be logged in');
	}

	public function testAuthHelperUnsuccessfullWithUnkownError(){
		$userRcEntries = array(array());
		OC_RoundCube_App::$RC_USER_ENTRIES = $userRcEntries;
		OC_RoundCube_App::$LOGIN_RESULT = false;
		$params = array(
				"uid" => 'user',
				"password" => 'password',
		);
		$loggedIn=OC_RoundCube_AuthHelper::login($params);
		$this->assertFalse($loggedIn,'Should not be logged in');
	}
}

