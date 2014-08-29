<?php

class OC_RoundCube_App {

	public static $DB_USER;

	public static $LOGIN_USER;

	public static function writeBasicData($meUser) {
		return self::checkLoginData($meUser, 1);
	}

	public static function checkLoginData($meUser, $written = 0) {
		if (OC_RoundCube_App::$DB_USER) {
			if(OC_RoundCube_App::$DB_USER == OC_RoundCube_App::$LOGIN_USER){
				return OC_RoundCube_App::$LOGIN_USER;
			} else {
				return OC_RoundCube_App::$DB_USER;
			}
		} else {
			return OC_RoundCube_App::$LOGIN_USER;
		}
	}

	public static function generateKeyPair($user, $pass = false){
	}


	public static function getPublicKey($user)
	{
	}

	public static function getPrivateKey($user, $password = false)
	{
	}

	public static function cryptMyEntry($entry, $pubKey) {

	}

	public static function decryptMyEntry($data, $privKey) {

	}


	public static $CRYPTEMAIL;
	public static function cryptEmailIdentity($ocUser, $emailUser, $emailPassword){
		return OC_RoundCube_App::$CRYPTEMAIL;
	}

	public static function logout($rcHost, $rcPort, $maildir, $user) {
	}

	public static function login($rcHost, $rcPort, $maildir, $pLogin, $pPassword)
	{
	}

	public static function refresh($rcHost, $rcPort, $maildir){
	}

	public static function showMailFrame($rcHost, $rcPort, $maildir) {

	}

}
