<?php

// namespace OCA\roundcube;

// OC_App::loadApp('roundcube');
require_once 'PHPUnit/Autoload.php';
require_once 'mocks_oc.php';
require_once 'mocks_ocp.php';
require_once ("appinfo/app.php");
require_once ("lib/RoundCubeLogin.class.php");
require_once ("lib/RoundCubeApp.class.php");
require_once ("lib/MailNetworkingException.class.php");
require_once ("lib/MailLoginException.class.php");

/**
 * Simple Unit test which checks the PHP syntax of all used files in the app
 *
 * @author mreinhardt
 *        
 *        
 */
class OC_RoundCube_App_Test extends PHPUnit_Framework_TestCase
{

    private $mockedRcLogin;

    /**
     * Start http server instance in background.
     *
     * @return Mock_Http_Server public function start()
     *         {
     *         shell_exec('cd '.$this->getBinDir().';nohup ./httpd -p '.$this->getPort().' -w '.$this->getWebDir().' -P '.$this->getPidFile().' > /dev/null 2>&1 < /dev/null &');
     *         usleep(300000);
     *         return $this;
     *         }
     */
    protected function setUp()
    {
        $http_response_header = array(
            array(
                'location' => '.\/?_task=mail',
                'set-cookie' => 'roundcube_sessauth=-del-; expires=Fri, 20-Mar-2015 19:37:22 GMT; Max-Age=-60; path=/; httponly
roundcube_sessid=ol359cpg593fjlkahfnhp2te23; path=/; HttpOnly
roundcube_sessauth=S3087d477dcee945a77d963975451aa11f9852a56; path=/; httponly'
            )
        );
        $mockedResponse = ' <div id="message"';
        $responseObj = new Response($http_response_header, $mockedResponse);
        $this->mockedRcLogin = $this->getMock('OC_RoundCube_Login', array(
            'isLoggedIn',
            'openUrlConnection',
            'emitAuthHeaders',
            'closeUrlConnection',
            'getConnectionData',
            'getResponseHeader',
            'setRcCookies'
        ), array(
            'localhost',
            '4443',
            'mail',
            true
        ));
        $this->mockedRcLogin->expects($this->any())
            ->method('openUrlConnection')
            ->will($this->returnValue($responseObj));
        $this->mockedRcLogin->expects($this->any())
            ->method('closeUrlConnection')
            ->will($this->returnValue($responseObj));
    }

    public function testAppSuccessLogin()
    {
        $this->mockedRcLogin->expects($this->any())
            ->method('isLoggedIn')
            ->will($this->returnValue(true));
        $loggedIn = $this->mockedRcLogin->login("user", "password");
        $this->assertTrue($loggedIn, 'Should be logged in');
    }

    public function testKeyGeneration()
    {
        // reset
        OCP\Config::$USERVALUES = array();
        
        $result = OC_RoundCube_App::generateKeyPair('user', 'pass');
        $privateKey = $result['privateKey'];
        $publicKey = $result['publicKey'];
        //$this->assertEquals(get_resource_type($privateKey), 'OpenSSL key');
        $this->assertNotNull($privateKey, 'Private key should not be empty.');
        $this->assertNotNull($publicKey, 'Public key should not be empty.');
        $readPrivateKey = OC_RoundCube_App::getPrivateKey('user', 'pass');
        $readPublicKey = OC_RoundCube_App::getPublicKey('user');
        $this->assertEquals($publicKey, $readPublicKey);
    }

    public function testCrypt()
    {
        // setup
        $testOcUser = 'testUser1';
        $testRcUser = 'testUser2';
        // reset
        OCP\Config::$USERVALUES = array();

        $result = OC_RoundCube_App::generateKeyPair($testOcUser, 'Passw0rd!');
        $privateKey = OC_RoundCube_App::getPrivateKey($testOcUser, 'Passw0rd!');
        $this->assertNotNull($privateKey, 'Private key should not be empty.');
        $encryptedMailData = OC_RoundCube_App::cryptEmailIdentity($testOcUser, $testRcUser, 'Passw0rd!', false);
        $mail_user = OC_RoundCube_App::decryptMyEntry($encryptedMailData['mail_user'], $privateKey);
        $mail_pass = OC_RoundCube_App::decryptMyEntry($encryptedMailData['mail_password'], $privateKey);
        $this->assertEquals($mail_user, $testRcUser);
        $this->assertEquals($mail_pass, 'Passw0rd!');
    }

    public function testSaveManualLoginDataWithErrors()
    {
        // reset
        OCP\Config::$USERVALUES = array();
        
        $appName = "bla";
        $ocUser = "user";
        $ocPassword = "user";
        $rcUser = "rcUser";
        $rcPassword = "password";
        $result = OC_RoundCube_App::generateKeyPair($ocUser, $ocPassword);
        $this->assertFalse(OC_RoundCube_App::saveUserSettings($appName, $ocUser, $rcUser, $rcPassword), 'Should not save settings');
    }

    public function testSaveManualLoginDataWithCryptErrors()
    {
        $appName = "roundcube";
        $ocUser = "user";
        $rcUser = "rcUser";
        $rcPassword = "password";
        $this->assertFalse(OC_RoundCube_App::saveUserSettings($appName, $ocUser, $rcUser, $rcPassword), 'Should snot ave settings');
    }

    public function testAppUnsuccessfullLogin()
    {
        $this->mockedRcLogin->expects($this->any())
            ->method('isLoggedIn')
            ->will($this->returnValue(false));
        $loggedIn = $this->mockedRcLogin->login("user", "password");
        $this->assertFalse($loggedIn, 'Should not be logged in');
    }
}

