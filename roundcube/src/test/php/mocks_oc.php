<?php
class OC{
	/**
	 * Associative array for autoloading. classname => filename
	 */
	public static $CLASSPATH = array();

}

class OC_L10N{

	/**
	 * @brief Translating
	 * @param $text String The text we need a translation for
	 * @param array $parameters default:array() Parameters for sprintf
	 * @return \OC_L10N_String Translation or the same text
	 *
	 * Returns the translation. If no translation is found, $text will be
	 * returned.
	 */
	public function t($text, $parameters = array()) {
	}
}

class OC_App{
	/**
	 * Get the directory for the given app.
	 * If the app is defined in multiple directories, the first one is taken. (false if not found)
	 */
	public static function getAppPath($appid) {

		return $appid;
	}
}
