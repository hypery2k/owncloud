<?php

require_once 'lib/RoundCubeDBUtil.class.php';
require_once 'mocks_ocp.php';

class RoundCubeDBUtilTest extends PHPUnit_Framework_TestCase
{

	public function testTablefound(){
		$class = $this->getMockClass('OCP\Query', array('execute') );
		$class::staticExpects($this->any())
		->method('execute')
		->will($this->returnValue(''));
		$this->assertTrue(OC_RoundCube_DB_Util::tableExists(),"There should be an entry found");

	}
}

