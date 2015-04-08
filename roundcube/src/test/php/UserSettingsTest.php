<?php
require_once 'mocks_oc.php';
require_once 'mocks_ocp.php';
require_once 'mocks_db.php';
require_once 'mocks_RoundCubeApp.php';

/**
 * Simple Unit test which checks the PHP syntax of all used files in the app
 *
 * @author mreinhardt
 *        
 */
class UserSettingsOC7Test extends PHPUnit_Framework_TestCase
{

    protected function setUp()
    {
        $testUser = 'testUser';
        OCP\User::$LOGGEDIN = true;
        OCP\User::$USER = $testUser;
        OC_RoundCube_App::$DB_USER = $testUser;
        OC_RoundCube_App::$LOGIN_USER = $testUser;
    }

    public function testWithAutologin()
    {
        $_ = array(
            'ocVersion' => 7,
            'requesttoken' => 'abc1213'
        );
        $cfgClass = '';
        $l = new OC_L10N('roundcube');
        OCP\Config::$APPVALUES = array(
            'autoLogin' => true
        );
        require_once ("templates/tpl.userSettings.php");
    }

    public function testWithoutAutologin()
    {
        $_ = array(
            'ocVersion' => 7,
            'requesttoken' => 'abc1213'
        );
        $cfgClass = '';
        $l = new OC_L10N('roundcube');
        OCP\Config::$APPVALUES = array(
            'autoLogin' => false
        );
        require_once ("templates/tpl.userSettings.php");
        $_POST = array(
            'appname' => 'roundcube',
            'rc_mail_username' => 'user',
            'rc_mail_password' => 'password'
        );
    }
}

class UserSettingsOC8Test extends PHPUnit_Framework_TestCase
{

    protected function setUp()
    {
        $testUser = 'testUser';
        OCP\User::$LOGGEDIN = true;
        OCP\User::$USER = $testUser;
        OC_RoundCube_App::$DB_USER = $testUser;
        OC_RoundCube_App::$LOGIN_USER = $testUser;
    }

    public function testWithAutologin()
    {
        $_ = array(
            'ocVersion' => 8,
            'requesttoken' => 'abc1213'
        );
        $cfgClass = '';
        $l = new OC_L10N('roundcube');
        OCP\Config::$APPVALUES = array(
            'autoLogin' => true
        );
        require_once ("templates/tpl.userSettings.php");
    }

    public function testWithoutAutologin()
    {
        $_ = array(
            'ocVersion' => 8,
            'requesttoken' => 'abc1213'
        );
        $cfgClass = '';
        $l = new OC_L10N('roundcube');
        OCP\Config::$APPVALUES = array(
            'autoLogin' => false
        );
        require_once ("templates/tpl.userSettings.php");
        $_POST = array(
            'appname' => 'roundcube',
            'rc_mail_username' => 'user',
            'rc_mail_password' => 'password'
        );
    }
}

