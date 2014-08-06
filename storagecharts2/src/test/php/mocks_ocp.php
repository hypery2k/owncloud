<?php
namespace OCP;


class App {

	/**
	 * Check if the app is enabled, redirects to home if not
	 * @param string
	 */
	public static function checkAppEnabled( $app ) {
		return true;
	}
	/**
	 * Adds an entry to the navigation
	 * @param array containing the data
	 * @return boolean
	 *
	 * This function adds a new entry to the navigation visible to users. $data
	 * is an associative array.
	 * The following keys are required:
	 *   - id: unique id for this entry ('addressbook_index')
	 *   - href: link to the page
	 *   - name: Human readable name ('Addressbook')
	 *
	 * The following keys are optional:
	 *   - icon: path to the icon of the app
	 *   - order: integer, that influences the position of your application in
	 *	 the navigation. Lower values come first.
	 */
	public static function addNavigationEntry( $data ) {
	}


	/**
	 * Register a Configuration Screen that should appear in the personal settings section.
	 * @param $app string appid
	 * @param $page string page to be included
	 */
	public static function registerPersonal( $app, $page ) {
	}

	/**
	 * Register a Configuration Screen that should appear in the Admin section.
	 * @param $app string appid
	 * @param $page string page to be included
	 */
	public static function registerAdmin( $app, $page ) {
	}

}

class DB{

	public static function prepare($pSQL) {
		return new Query();
	}

}

class Config {

	/**
	 * Gets a value from config.php
	 * @param string $key key
	 * @param string $default = null default value
	 * @return string the value or $default
	 *
	 * This function gets the value from config.php. If it does not exist,
	 * $default will be returned.
	 */
	public static function getSystemValue( $key, $default = null ) {
		return "";
	}

	/**
	 * Gets the config value
	 * @param string $app app
	 * @param string $key key
	 * @param string $default = null, default value if the key does not exist
	 * @return string the value or $default
	 *
	 * This function gets a value from the appconfig table. If the key does
	 * not exist the default value will be returned
	 */
	public static function getAppValue( $app, $key, $default = null ) {
		return "";
	}
}

class BackgroundJob{
	public static function addRegularTask($klass, $method) {
		return true;
	}
}

class Query {

	public function execute(){
		//throw new \Exception();
	}
}

class User {

	/**
	 * Get the user id of the user currently logged in.
	 * @return string uid or false
	 */
	public static function getUser() {
		return "sc_user";
	}
}
class Util{

	const DEBUG = 1;

	public static function writeLog($pComponent, $logOuput,$loglevel) {
		echo $pComponent.': '.$logOuput;
		echo "\n";
	}

	/**
	 * add a javascript file
	 * @param string $application
	 * @param string $file
	 */
	public static function addScript( $application, $file = null ) {

	}


	public static function connectHook($pContext, $pHook,$pClass,$pMethod) {
	}

	/**
	 * Creates an url to the given app and file
	 * @param string $app app
	 * @param string $file file
	 * @param array $args array with param=>value, will be appended to the returned url
	 * 	The value of $args will be urlencoded
	 * @return string the url
	 */
	public static function linkTo( $app, $file, $args = array() ) {
	}


	/**
	 * Creates path to an image
	 * @param string $app app
	 * @param string $image image name
	 * @return string the url
	 */
	public static function imagePath( $app, $image ) {
	}

}