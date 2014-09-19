<?php

//namespace OCA\roundcube;

//OC_App::loadApp('roundcube');
require_once 'mocks_oc.php';
require_once 'mocks_ocp.php';
require_once("appinfo/app.php");
require_once("lib/RoundCubeLogin.class.php");
require_once("lib/RoundCubeApp.class.php");
require_once("lib/MailNetworkingException.class.php");
require_once("lib/MailLoginException.class.php");
/**
 * Simple Unit test which checks the PHP syntax of all used files in the app
 * @author mreinhardt
 *
*/
class OC_RoundCube_App_Test extends PHPUnit_Framework_TestCase {

	private $mockedRcLogin;

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
		$http_response_header=array('HTTP/1.1 200 OK',
				'Location: .\/?_task=mail','path=\/;Set-Cookie:roundcube_sessauth=Sfd5040c316832a3fd40750ccb1f15f58b47ddd39; roundcube_sessid=a4i22nr34a8nudn1ncagdu8jj4; 50be576f0ca87=4tf3l5l48q86dl6hobc4e9jb33');
		$mockedResponse=' <div id="message"';
		$responseObj= new Response($http_response_header,$mockedResponse);
		$this -> mockedRcLogin = $this->getMock('OC_RoundCube_Login',
				array('isLoggedIn','openUrlConnection','closeUrlConnection','getConnectionData','getResponseHeader','setRcCookies') ,
				array('localhost','443','mail',true)
		);
		$this -> mockedRcLogin->expects($this->any()) -> method('openUrlConnection') -> will($this -> returnValue($responseObj));
		$this -> mockedRcLogin->expects($this->any()) -> method('closeUrlConnection') -> will($this -> returnValue($responseObj));
	}

	public function testAppSuccessLogin(){
		$this -> mockedRcLogin->expects($this -> any()) -> method('isLoggedIn') -> will($this->returnValue(true));
		$loggedIn=$this -> mockedRcLogin -> login("user","password");
		$this->assertTrue($loggedIn,'Should be logged in');
	}

	public function testKeyGeneration(){
		// reset
		OCP\Config::$USERVALUES = array();

		$result = OC_RoundCube_App::generateKeyPair('user','pass');
		$privateKey = $result['privateKey'];
		$publicKey = $result['publicKey'];
		$this->assertEquals(get_resource_type($privateKey),'OpenSSL key');
		$this->assertNotNull($privateKey,'Private key should not be empty.');
		$this->assertNotNull($publicKey,'Public key should not be empty.');
		$readPrivateKey = OC_RoundCube_App::getPrivateKey('user','pass');
		$readPublicKey = OC_RoundCube_App::getPublicKey('user');
		$this->assertEquals($publicKey,$readPublicKey);
	}

	public function testCrypt(){
		// setup
		$testUser = 'testUser';
		// reset
		OCP\Config::$USERVALUES = array();

		$result = OC_RoundCube_App::generateKeyPair($testUser,'Passw0rd!');
		$privateKey = $result['privateKey'];
		$publicKey = $result['publicKey'];
		$this->assertEquals(get_resource_type($privateKey),'OpenSSL key');
		$this->assertNotNull($privateKey,'Private key should not be empty.');
		$this->assertNotNull($publicKey,'Public key should not be empty.');
		$encryptedMailData=OC_RoundCube_App::cryptEmailIdentity($testUser,$testUser,'Passw0rd!',false);
		$mail_user = OC_RoundCube_App::decryptMyEntry($encryptedMailData['mail_user'],$privateKey);
		$mail_pass = OC_RoundCube_App::decryptMyEntry($encryptedMailData['mail_password'],$privateKey);
		$this->assertEquals($mail_user,$testUser);
		$this->assertEquals($mail_pass,'Passw0rd!');
	}

	public function testAppUnsuccessfullLogin(){
		$this -> mockedRcLogin->expects($this -> any()) -> method('isLoggedIn') -> will($this->returnValue(false));
		$loggedIn=$this -> mockedRcLogin -> login("user","password");
		$this->assertFalse($loggedIn,'Should not be logged in');
	}
}

