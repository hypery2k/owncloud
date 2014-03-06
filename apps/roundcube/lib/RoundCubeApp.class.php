<?php

/**
 * ownCloud - roundcube mail plugin
 *
 * @author Martin Reinhardt and David Jaedke
 * @copyright 2012 Martin Reinhardt contact@martinreinhardt-online.de
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU AFFERO GENERAL PUBLIC LICENSE
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU AFFERO GENERAL PUBLIC LICENSE for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

/**
 * This class manages the roundcube app. It enables the db integration and
 * connects to the roundcube installation via the roundcube API
 */
class OC_RoundCube_App {
  public $mailData = '';

  /**
   * @brief write basic information for the user in the app configu
   * @param user object $meUser
   * @returns true/false
   *
   * This function creates a simple personal entry for each user to distinguish them later
   *
   * It also chekcs the login data
   */
  public static function writeBasicData($meUser) {
    OCP\Util::writeLog('roundcube', 'Writing basic data for ' . $meUser, OCP\Util::DEBUG);
    $stmt = OCP\DB::prepare("INSERT INTO *PREFIX*roundcube (oc_user) VALUES (?)");
    $result = $stmt -> execute(array($meUser));
    return self::checkLoginData($meUser, 1);
  }

  /**
   * @brief chek the login parameters
   * @param user object $meUser
   * @param write the basic user data to db
   * @returns the login data
   *
   * This function tries to load the configured login data for roundcube and return it.
   */
  public static function checkLoginData($meUser, $written = 0) {
    OCP\Util::writeLog('roundcube', 'Checking login data for ' . $meUser, OCP\Util::DEBUG);
    $stmt = OCP\DB::prepare('SELECT * FROM *PREFIX*roundcube WHERE oc_user=?');
    $result = $stmt -> execute(array($meUser));
    $mailEntries = $result -> fetchAll();
    if (count($mailEntries) > 0) {
      OCP\Util::writeLog('roundcube', 'Found login data for ' . $meUser, OCP\Util::DEBUG);
      return $mailEntries;
    } elseif ($written == 0) {
      OCP\Util::writeLog('roundcube', 'Did not found login data for ' . $meUser, OCP\Util::DEBUG);
      return self::writeBasicData($meUser);
    }
  }

  /**
   * @brief Generate a private/public key pair.
   * @param $user User ID.
   * @param $password Passphrase
   *
   * @return array('privateKey', 'publicKey')
   */
  public static function generateKeyPair($user, $pass = false)
  {
    /* Create the private and public key */
    $res = openssl_pkey_new();

    /* Extract the private key from $res to $privKey */
    if (!openssl_pkey_export($res, $privKey, $password)) {
      return false;
    }

    /* Extract the public key from $res to $pubKey */
    $pubKey = openssl_pkey_get_details($res);

    if ($pubKey === false) {
      return false;
    }
    $pubKey = $pubKey['key'];

    // We now store the public key unencrypted in the user preferences.
    // The private key already is encrypted with the user's password,
    // so there is no need to encrypt it again.

    \OCP\Config::setUserValue($user, 'roundcube', 'publicSSLKey', $pubKey);
    \OCP\Config::setUserValue($user, 'roundcube', 'privateSSLKey', $privKey);

    return array('privateKey' => $privKey, 'publicKey' => $pubKey);
  }


  public static function getPublicKey($user)
  {
    $pubKey = \OCP\Config::getUserValue($user, 'roundcube', 'publicSSLKey', false);
    return $pubKey;
  }

  public static function getPrivateKey($user, $password = false)
  {
    if ($user == false && $password == false &&
        isset($_SESSION['OC\\ROUNDCUBE\\privateKey'])) {
      return $_SESSION['OC\\ROUNDCUBE\\privateKey'];
    } else if ($user == false) {
      return false;
    }

    $privKey = \OCP\Config::getUserValue($user, 'roundcube', 'privateSSLKey', false);
    if ($privKey === false) {
      $result = self::generateKeyPair($user, $password);
      $privKey = $result['privateKey'];
    } else {
      $privKey = openssl_pkey_get_private($privKey, $password);
      if ($privKey === false) {
        return false;
      }
      if (openssl_pkey_export($privKey, $privKey) === false) {
        return false;
      }
    }
    $_SESSION['OC\\ROUNDCUBE\\privateKey'] = $privKey;
    
    return $privKey;
  }

  /**
   * @brief own cryptfunction
   * @param object to encrypt $entry
   * @returns encrypted entry
   *
   */
  public static function cryptMyEntry($entry, $pubKey) {
    if (openssl_public_encrypt($entry, $entry, $pubKey) === false) {
      return false;
    }
    $entry = base64_encode($entry);
    return $entry;
  }

  /**
   * @brief own cryptfunction
   * @param object to encrypt $hex
   * @returns decrypted entry
   *
   */
  public static function decryptMyEntry($data, $privKey) {
    $data = base64_decode($data);
    if (openssl_private_decrypt($data, $data, $privKey) === false) {
      return;
    }
    return $data;
  }

  /**Use the pulic key of the respective user to encrypt the given
   * email identity and store it in the data-base.
   *
   * @param[in] $ocUuser The OwnCloud user id
   *
   * @param[in] $emailUser The IMAP account Id
   *
   * @param[in] $emailPassword The IMAP credentials.
   *
   */
  public static function cryptEmailIdentity($ocUser, $emailUser, $emailPassword)
  {
    $mail_userdata_entries = OC_RoundCube_App::checkLoginData($ocUser);
    if ($mail_userdata_entries === false) {
      return false;
    }
    $mail_userdata = $mail_userdata_entries[0];
    $myID = $mail_userdata['id'];

    $pubKey = self::getPublicKey($ocUser);
    if ($pubKey === false) {
      return false;
    }
    $emailUser = OC_RoundCube_App::cryptMyEntry($emailUser, $pubKey);
    $emailPassword = OC_RoundCube_App::cryptMyEntry($emailPassword, $pubKey);

    if ($emailUser === false || $emailPassword === false) {
      return false;
    }

    $stmt = OCP\DB::prepare("UPDATE *PREFIX*roundcube SET mail_user = ?, mail_password = ? WHERE id = ?");
    $result = $stmt -> execute(array($emailUser, $emailPassword, $myID));

    return $result;
  }

  /**
   * Logs the current user out from roundcube
   * @param roundcube server address
   * @param roundcube server port
   * @param path to roundcube installation, Note: The first parameter is the URL-path of the RC inst
   * NOT the file-system path http://host.com/path/to/roundcube/ --> "/path/to/roundcube" $maildir
   * @param roundcube usernam $user
   */
  public static function logout($rcHost, $rcPort, $maildir, $user) {
    $enableDebug = OCP\Config::getAppValue('roundcube', 'enableDebug', 'true');

    $rcl = new OC_RoundCube_Login($rcHost, $rcPort, $maildir, $enableDebug);
    if ($rcl -> logout()) {
      OCP\Util::writeLog('roundcube', $user.' successfully logged off from roundcube ', OCP\Util::INFO);
    } else {
      OCP\Util::writeLog('roundcube', 'Failed to log-off '.$user.' from roundcube ', OCP\Util::ERROR);
    }
  }

  public static function login($rcHost, $rcPort, $maildir, $ownUser, $ownPass)
  {
    // Create RC login object.
    $enableDebug = OCP\Config::getAppValue('roundcube', 'enableDebug', 'true');
    $rcl = new OC_RoundCube_Login($rcHost, $rcPort, $maildir, $enableDebug);

    // Try to login
    OCP\Util::writeLog('roundcube', 'Trying to log into roundcube webinterface under ' . $maildir . ' as user ' . $ownUser, OCP\Util::DEBUG);
    if ($rcl -> isLoggedIn()) {
      $rcl -> logout();
      $rcl = new OC_RoundCube_Login($rcHost, $rcPort, $maildir, $enableDebug);
    }
    if ($rcl -> login($ownUser, $ownPass)) {
      OCP\Util::writeLog('roundcube', $ownUser.' successfully logged into roundcube ', OCP\Util::INFO);
    } else {
      // If the login fails, display an error message in the loggs
      OCP\Util::writeLog('roundcube', $ownUser.': RoundCube can\'t login to roundcube due to a login error to roundcube', OCP\Util::ERROR);
    }
  }

  public static function refresh($rcHost, $rcPort, $maildir)
  {
    // Create RC login object.
    $enableDebug = OCP\Config::getAppValue('roundcube', 'enableDebug', 'true');

    $rcl = new OC_RoundCube_Login($rcHost, $rcPort, $maildir, $enableDebug);

    // Try to refresh
    OCP\Util::writeLog('roundcube', 'Trying to refresh RoundCube session under ' . $maildir, OCP\Util::DEBUG);
    if ($rcl -> isLoggedIn()) {
      OCP\Util::writeLog('roundcube', 'Probably successfully refreshed the RC session.', OCP\Util::INFO);
    } else {
      OCP\Util::writeLog('roundcube', 'Probably failed to refresh the RC session.', OCP\Util::ERROR);
    }
  }

  /**
   *
   * @brief showing up roundcube iFrame
   * @param roundcube username $ownUser
   * @param path to roundcube installation, Note: The first parameter is the URL-path of the RC inst
   * NOT the file-system path http://host.com/path/to/roundcube/ --> "/path/to/roundcube" $maildir
   * @param roundcube username $ownUser
   * @param roundcube password $ownPass
   *
   */
  public static function showMailFrame($rcHost, $rcPort, $maildir, $ownUser = false, $ownPass = false) {

    // TODO remove obsolete params
    $returnObject = new OC_Mail_Object();

    // Create RC login object.
    $enableDebug = OCP\Config::getAppValue('roundcube', 'enableDebug', 'true');

    $rcl = new OC_RoundCube_Login($rcHost, $rcPort, $maildir, $enableDebug);

    try {
      if (!$rcl->isLoggedIn()) {
        // If the login fails, display an error message in the loggs
        OCP\Util::writeLog('roundcube', 'RoundCube: not logged in.', OCP\Util::ERROR);
      }
      OCP\Util::writeLog('roundcube', 'Preparing iFrame for roundcube:' . $rcl -> getRedirectPath(), OCP\Util::DEBUG);
      // loader image
      $loader_image = OCP\Util::imagePath('roundcube', 'loader.gif');
      $disable_header_nav = OCP\Config::getAppValue('roundcube', 'removeHeaderNav', 'false');
      $disable_control_nav = OCP\Config::getAppValue('roundcube', 'removeControlNav', 'false');

      // create iFrame begin
      $returnObject -> appendHtmlOutput('<img src="' . $loader_image . '" id="loader">');
      $returnObject -> appendHtmlOutput('<iframe src="' . $rcl -> getRedirectPath() . '" id="roundcubeFrame"  oncom=name="roundcube" width="100%" width="100%" style="display:none;">  </iframe>');
      $returnObject -> appendHtmlOutput('<input type="hidden" id="disable_header_nav" value="' . $disable_header_nav . '"/>');
      $returnObject -> appendHtmlOutput('<input type="hidden" id="disable_control_nav" value="' . $disable_control_nav . '"/>');
      // create iFrame end
    } catch (OC_Mail_NetworkingException $ex_net) {
      $returnObject -> setErrorOccurred(true);
      $returnObject -> setErrorCode(OC_Mail_Object::ERROR_CODE_NETWORK);
      $returnObject -> setHtmlOutput('');
      $returnObject -> setErrorDetails("ERROR: Technical problem during trying to connect to roundcube server, " . $ex_net -> getMessage());
      OCP\Util::writeLog('roundcube', 'RoundCube can\'t login to roundcube due to a network connection exception to roundcube', OCP\Util::ERROR);
    } catch (OC_Mail_LoginException $ex_login) {
      $returnObject -> setErrorOccurred(true);
      $returnObject -> setErrorCode(OC_Mail_Object::ERROR_CODE_LOGIN);
      $returnObject -> setHtmlOutput('');
      $returnObject -> setErrorDetails("ERROR: Technical problem, " . $ex_login -> getMessage());
      OCP\Util::writeLog('roundcube', 'RoundCube can\'t login to roundcube due to a login exception to roundcube', OCP\Util::ERROR);
    } catch (OC_Mail_RC_InstallNotFoundException $ex_login) {
      $returnObject -> setErrorOccurred(true);
      $returnObject -> setErrorCode(OC_Mail_Object::ERROR_CODE_RC_NOT_FOUND);
      $returnObject -> setHtmlOutput('');
      $returnObject -> setErrorDetails("ERROR: Technical problem, " . $ex_login -> getMessage());
      OCP\Util::writeLog('roundcube', 'RoundCube can\'t be found on the given path.', OCP\Util::ERROR);
    } catch (Exception $ex_login) {
      $returnObject -> setErrorOccurred(true);
      $returnObject -> setErrorCode(OC_Mail_Object::ERROR_CODE_GENERAL);
      $returnObject -> setHtmlOutput('');
      $returnObject -> setErrorDetails("ERROR: Technical problem, " . $ex_login -> getMessage());
      OCP\Util::writeLog('roundcube', 'RoundCube can\'t login to roundcube due to a unkown exception to roundcube', OCP\Util::ERROR);
    }

    return $returnObject;

  }

}
?>
