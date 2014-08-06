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
		$GLOBALS["http_response_header"]='';
	}



	public function testConnectionError(){

		$fp = '';
		$mockedRcLogin = $this->getMock('OC_RoundCube_Login',
				array('openUrlConnection','closeUrlConnection') ,
				array('localhost','443','mail')
		);
		$mockedRcLogin->expects($this->any())
		->method('openUrlConnection')
		->will($this->returnValue($fp));
		$mockedRcLogin->expects($this->any())
		->method('closeUrlConnection')
		->will($this->returnValue($fp));
		try {
			$mockedRcLogin -> login("user","password");
		}
		catch (OC_Mail_NetworkingException $expected) {
			return;
		}

		$this->fail('An expected exception has not been raised.');
	}

	public function testUnkownResponse(){
		$fp = 'any';
		$mockedResponse=false;
		$mockedRcLogin = $this->getMock('OC_RoundCube_Login',
				array('openUrlConnection','closeUrlConnection','getConnectionData') ,
				array('localhost','443','mail')
		);
		$mockedRcLogin->expects($this->any())
		->method('openUrlConnection')
		->will($this->returnValue($fp));
		$mockedRcLogin->expects($this->any())
		->method('closeUrlConnection')
		->will($this->returnValue($fp));
		$mockedRcLogin->expects($this->any())
		->method('getConnectionData')
		->will($this->returnValue($mockedResponse));
		try {
			$mockedRcLogin -> login("user","password");
		}
		catch (OC_Mail_NetworkingException $expected) {
			return;
		}

		$this->fail('An expected exception has not been raised.');

	}

	public function testUnkownLoginState1(){
		$http_response_header=array('');

		$fp = 'any';
		$mockedResponse='';
		$mockedRcLogin = $this->getMock('OC_RoundCube_Login',
				array('openUrlConnection','closeUrlConnection','getConnectionData','getResponseHeader') ,
				array('localhost','443','mail')
		);
		$mockedRcLogin->expects($this->any())
		->method('openUrlConnection')
		->will($this->returnValue($fp));
		$mockedRcLogin->expects($this->any())
		->method('closeUrlConnection')
		->will($this->returnValue($fp));
		$mockedRcLogin->expects($this->any())
		->method('getConnectionData')
		->will($this->returnValue($mockedResponse));
		$mockedRcLogin->expects($this->any())
		->method('getResponseHeader')
		->will($this->returnValue($http_response_header));
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
		$http_response_header=array('HTTP/1.1 200 OK',		
		'path=\/;Set-Cookie:roundcube_sessauth=Sfd5040c316832a3fd40750ccb1f15f58b47ddd39; roundcube_sessid=a4i22nr34a8nudn1ncagdu8jj4; 50be576f0ca87=4tf3l5l48q86dl6hobc4e9jb33');

		$fp = 'any';
		$mockedResponse=' <div id="message"';
		$mockedRcLogin = $this->getMock('OC_RoundCube_Login',
				array('openUrlConnection','closeUrlConnection','getConnectionData','getResponseHeader') ,
				array('localhost','443','mail')
		);
		$mockedRcLogin->expects($this->any())
		->method('openUrlConnection')
		->will($this->returnValue($fp));
		$mockedRcLogin->expects($this->any())
		->method('closeUrlConnection')
		->will($this->returnValue($fp));
		$mockedRcLogin->expects($this->any())
		->method('getConnectionData')
		->will($this->returnValue($mockedResponse));
		$mockedRcLogin->expects($this->any())
		->method('getResponseHeader')
		->will($this->returnValue($http_response_header));
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

		$fp = 'any';
		$mockedResponse=' <div id="message"';
		$mockedRcLogin = $this->getMock('OC_RoundCube_Login',
				array('openUrlConnection','closeUrlConnection','getConnectionData','getResponseHeader') ,
				array('localhost','443','mail')
		);
		$mockedRcLogin->expects($this->any())
		->method('openUrlConnection')
		->will($this->returnValue($fp));
		$mockedRcLogin->expects($this->any())
		->method('closeUrlConnection')
		->will($this->returnValue($fp));
		$mockedRcLogin->expects($this->any())
		->method('getConnectionData')
		->will($this->returnValue($mockedResponse));
		$mockedRcLogin->expects($this->any())
		->method('getResponseHeader')
		->will($this->returnValue($http_response_header));
		$mockedRcLogin -> login("user","password");

	}
}
