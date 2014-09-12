<?php

require_once 'mocks_oc.php';
require_once 'mocks_ocp.php';
require_once 'mocks_db.php';
require_once 'mocks_app.php';

/**
 * Simple Unit test which checks the PHP syntax of all used files in the app
 * @author mreinhardt
 *
 */
class UserSettingsOC7Test extends PHPUnit_Framework_TestCase {

	protected function setUp() {
		$testUser = 'testUser';
		OCP\User::$LOGGEDIN=true;
		OCP\User::$USER=$testUser;
		OC_RoundCube_App::$DB_USER=$testUser;
		OC_RoundCube_App::$LOGIN_USER=$testUser;
	}

	public function testWithAutologin(){
		$_=array('ocVersion'=> 7,'requesttoken'=> 'abc1213');
		$cfgClass='';
		$l=new OC_L10N('roundcube');
		OCP\Config::$APPVALUE=array('autoLogin'  => true);
		require_once("templates/tpl.userSettings.php");
	}

	public function testWithoutAutologin(){
		$_=array('ocVersion'=> 7,'requesttoken'=> 'abc1213');
		$cfgClass='';
		$l=new OC_L10N('roundcube');
		OCP\Config::$APPVALUE=array('autoLogin'  => false);
		require_once("templates/tpl.userSettings.php");
		$_POST=array('appname'  => 'roundcube');
		$_POST=array('rc_mail_username'  => 'user');
		$_POST=array('rc_mail_password'  => 'password');
		OC_RoundCube_App::$CRYPTEMAIL=true;
		//require_once("ajax/userSettings.php");

	}
}

