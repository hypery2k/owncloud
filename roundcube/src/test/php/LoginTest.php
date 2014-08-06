<?php

//namespace OCA\roundcube;

//OC_App::loadApp('roundcube');
require_once 'mocks_oc.php';
require_once 'mocks_ocp.php';
require_once("appinfo/app.php");
require_once("lib/RoundCubeLogin.class.php");
require_once("lib/MailNetworkingException.class.php");
require_once("lib/MailLoginException.class.php");


/**
 * Test login
 * @author mreinhardt
 *
*/
class LoginTest extends PHPUnit_Framework_TestCase {



	protected function setUp() {
	}



	public function testConnectionError(){

		$rcLogin = new OC_RoundCube_Login('localhost','443','mail');
		try {
			$rcLogin -> login("user","password");
		}
		catch (OC_Mail_NetworkingException $expected) {
			return;
		}

		$this->fail('An expected exception has not been raised.');
	}

	public function testUnkownResponse(){
		$header=array('');
		$content=false;
		$responseObj= new Response($header,$content);
		$mockedRcLogin = $this->getMock('OC_RoundCube_Login',
				array('openUrlConnection','closeUrlConnection','getConnectionData') ,
				array('localhost','443','mail')
		);
		$mockedRcLogin->expects($this->any())
		->method('openUrlConnection')
		->will($this->returnValue($responseObj));
		$mockedRcLogin->expects($this->any())
		->method('closeUrlConnection')
		->will($this->returnValue($responseObj));
		try {
			$mockedRcLogin -> login("user","password");
		}
		catch (OC_Mail_NetworkingException $expected) {
			return;
		}

		$this->fail('An expected exception has not been raised.');

	}

	public function testUnkownLoginState1(){
		$header=array('');
		$content='';
		$responseObj= new Response($header,$content);
		$mockedRcLogin = $this->getMock('OC_RoundCube_Login',
				array('openUrlConnection','closeUrlConnection','getConnectionData','getResponseHeader') ,
				array('localhost','443','mail')
		);
		$mockedRcLogin->expects($this->any())
		->method('openUrlConnection')
		->will($this->returnValue($responseObj));
		$mockedRcLogin->expects($this->any())
		->method('closeUrlConnection')
		->will($this->returnValue($responseObj));
		try {
			$mockedRcLogin -> login("user","password");
		}
		catch (OC_Mail_LoginException $expected) {
			return;
		}

	}

	/**
	 * Unkown location
	 */
	public function testUnkownLoginState2(){
		$header=array('HTTP/1.1 200 OK','path=\/;Set-Cookie:roundcube_sessauth=Sfd5040c316832a3fd40750ccb1f15f58b47ddd39; roundcube_sessid=a4i22nr34a8nudn1ncagdu8jj4; 50be576f0ca87=4tf3l5l48q86dl6hobc4e9jb33');
		$content=' <div id="message"';
		$responseObj= new Response($header,$content);
		$mockedRcLogin = $this->getMock('OC_RoundCube_Login',
				array('openUrlConnection','closeUrlConnection','getConnectionData','getResponseHeader') ,
				array('localhost','443','mail')
		);
		$mockedRcLogin->expects($this->any())
		->method('openUrlConnection')
		->will($this->returnValue($responseObj));
		$mockedRcLogin->expects($this->any())
		->method('closeUrlConnection')
		->will($this->returnValue($responseObj));
		try {
		$mockedRcLogin -> login("user","password");		
		}
		catch (OC_Mail_LoginException $expected) {
			return;
		}

	}

	public function testSuccessfullLogin(){
		$http_response_header=array('HTTP/1.1 200 OK',
				'Location: .\/?_task=mail',
				'path=\/;Set-Cookie:roundcube_sessauth=Sfd5040c316832a3fd40750ccb1f15f58b47ddd39; roundcube_sessid=a4i22nr34a8nudn1ncagdu8jj4; 50be576f0ca87=4tf3l5l48q86dl6hobc4e9jb33');
		$mockedResponse=' <div id="message"';
		$responseObj= new Response($http_response_header,$mockedResponse);
		$mockedRcLogin = $this->getMock('OC_RoundCube_Login',
				array('openUrlConnection','closeUrlConnection','getConnectionData','getResponseHeader') ,
				array('localhost','443','mail')
		);
		$mockedRcLogin->expects($this->any())
		->method('openUrlConnection')
		->will($this->returnValue($responseObj));
		$mockedRcLogin->expects($this->any())
		->method('closeUrlConnection')
		->will($this->returnValue($responseObj));
		$mockedRcLogin -> login("user","password");

	}
}
