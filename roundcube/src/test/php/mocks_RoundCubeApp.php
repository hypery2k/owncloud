<?php

class OC_RoundCube_App
{

    const SESSION_ATTR_RCUSER = 'sessionKeyRc';

    public static $DB_USER;

    public static $LOGIN_USER;

    public static $LOGIN_RESULT = false;

    public static $RC_USER_ENTRIES;

    public static $PRIV_KEY = 'key';

    public static $PUB_KEY = 'key';

    public static $SESSION_DATA = array();

    public static function checkLoginData($ocUser, $written = 0)
    {
        if (OC_RoundCube_App::$DB_USER) {
            if (OC_RoundCube_App::$DB_USER == OC_RoundCube_App::$LOGIN_USER) {
                return self::$RC_USER_ENTRIES;
            } else {
                return;
            }
        } else {
            return self::$RC_USER_ENTRIES;
        }
    }

    public static function setSessionVariable($key, $value)
    {
        $SESSION_DATA[$key] = $value;
    }

    public static function getSessionVariable($key)
    {
        return isset($SESSION_DATA[$key]) ? $SESSION_DATA[$key] : false;
    }

    public static function getPublicKey($user)
    {
        return self::$PUB_KEY;
    }

    public static function getPrivateKey($user)
    {
        return self::$PUB_KEY;
    }

    public static function login($rcHost, $rcPort, $maildir, $pLogin, $pPassword)
    {
        return self::$LOGIN_RESULT;
    }

    public static function logout($rcHost, $rcPort, $maildir, $user)
    {
        return self::$LOGIN_RESULT;
    }

    public static function refresh($rcHost, $rcPort, $maildir)
    {
        return self::$LOGIN_RESULT;
    }

    public static function cryptMyEntry($entry, $pubKey)
    {
        return $entry;
    }

    public static function decryptMyEntry($data, $privKey)
    {
        return $data;
    }
}