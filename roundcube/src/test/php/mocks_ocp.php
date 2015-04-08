<?php
namespace OCP;


class App {

	public static function addNavigationEntry( $data ) {
	}

	public static function registerPersonal( $app, $page ) {
	}

	public static function registerAdmin( $app, $page ) {
	}

	public static function checkAppEnabled($app) {
	}

}

class DB{

	public static function prepare($pSQL) {
		return new Query();
	}

}

class Config {

	public static $APPVALUES;

	public static $USERVALUES = array();
	public static function getAppValue( $app, $key, $default = null ) {
		if($default){
			return $default;
		} else{
			return Config::$APPVALUES[$key];
		}
	}

	public static function getUserValue( $user, $app, $key, $default = null ) {
		return Config::$USERVALUES[$key];
	}

	public static function setUserValue( $user, $app, $key, $value ) {
		Config::$USERVALUES = array_merge(Config::$USERVALUES,array($key => $value));
	}


}

class User{
	public static $LOGGEDIN=true;
	public static function checkLoggedIn() {
		return User::$LOGGEDIN;
	}

	public static $USER;
	public static function getUser() {
		return User::$USER;
	}
}

class JSON{
    
    public static function error($data){
        
    }
    
    public static function success($data){
        
    }
    
	public static function checkLoggedIn() {

	}
	public static function checkAppEnabled($app) {

	}
	public static function callCheck() {

	}
}


class BackgroundJob{
	public static function addRegularTask($klass, $method) {
		return true;
	}
}

class Query {

	public function execute(){
		return new Result();
	}
}

class Result {

	public function fetchAll(){
		return false;
	}
	
}
class Util{

	const DEBUG = 1;

	const ERROR = 2;

	const INFO = 3;

	public static function writeLog($pComponent, $logOuput, $loglevel) {
		echo $pComponent.': '.$logOuput;
		echo "\n";
	}

	public static function addScript( $application, $file = null ) {

	}

	public static function addStyle( $application, $file = null ) {

	}

	public static function connectHook($pContext, $pHook,$pClass,$pMethod) {
	}

	public static function linkTo( $app, $file, $args = array() ) {
	}

	public static function imagePath( $app, $image ) {
	}

}

class Template{

	public static function assign( $param, $value ) {

	}

	public static function fetchPage( $param, $value ) {

	}
}