<?php
namespace OCP;

class DB{

	public static function prepare($pSQL) {
		return new Query();
	}

}

class Query {

	public function execute(){
		//throw new \Exception();
	}
}
class Util{

	const DEBUG = 1;

	public static function writeLog($pComponent, $logOuput,$loglevel) {
		echo $pComponent.': '.$logOuput;
		echo "\n";
	}
}
?>