<?php
/**
 * ownCloud - roundcube auth helper
 *
 * @author Martin Reinhardt
 * @copyright 2013 Martin Reinhardt contact@martinreinhardt-online.de
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
class OC_RoundCube_AuthHelper {

  public static function login($params) {
    try {
      $username = $params['uid'];
      $password = $params['password'];

      OCP\Util::writeLog('roundcube', 'Preparing login of user "'.$username.'" into roundcube', OCP\Util::DEBUG);

      $maildir = OCP\Config::getAppValue('roundcube', 'maildir', '');
      $rc_host = OCP\Config::getAppValue('roundcube', 'rcHost', OC_Request::serverHost());
      $rc_port = OCP\Config::getAppValue('roundcube', 'rcPort', '');

      $enable_auto_login = OCP\Config::getAppValue('roundcube', 'autoLogin', false);
      
      if ($enable_auto_login) {
        // SSO attempt
        $mail_username = $username;
        $mail_password = $password;
      } else {
        // Fetch credentials from data-base
        $mail_userdata_entries = OC_RoundCube_App::checkLoginData($username);
        // TODO create dropdown list
        $mail_userdata = $mail_userdata_entries[0];

        $privKey = OC_RoundCube_App::getPrivateKey($username, $password);
        
        $mail_username = OC_RoundCube_App::decryptMyEntry($mail_userdata['mail_user'], $privKey);
        $mail_password = OC_RoundCube_App::decryptMyEntry($mail_userdata['mail_password'], $privKey);
      }      
      // save active mail username
      OCP\Config::setAppValue('roundcube', 'mail_username', $mail_username);

      OC_RoundCube_App::login($rc_host, $rc_port, $maildir, $mail_username, $mail_password);
    } catch (Exception $e) {
      // We got an exception == table not found
      OCP\Util::writeLog('roundcube', 'OC_RoundCube_AuthHelper.class.php: ' . 'Login error.' . $e,
                         OCP\Util::DEBUG);
      return false;
    }
  }
  

  public static function logout($params) {
    try {
      OCP\Util::writeLog('roundcube', 'LOGOUT HOOK: Preparing logout of user from roundcube.', OCP\Util::DEBUG);
      $maildir = OCP\Config::getAppValue('roundcube', 'maildir', '');
      $rc_host = OCP\Config::getAppValue('roundcube', 'rcHost', OC_Request::serverHost());
      $rc_port = OCP\Config::getAppValue('roundcube', 'rcPort', '');

      OC_RoundCube_App::logout($rc_host, $rc_port, $maildir, OCP\User::getUser());
      OCP\Util::writeLog('roundcube', 'Logout of user '.OCP\User::getUser().' from roundcube done', OCP\Util::INFO);
    } catch (Exception $e) {
      // We got an exception == table not found
      OCP\Util::writeLog('roundcube', 'OC_RoundCube_AuthHelper.class.php: ' . 'Logout/Session cleaning causing errors.' . $e, OCP\Util::DEBUG);
      return false;
    }
  }

  public static function refresh() {
    try {
      OCP\Util::writeLog('roundcube', 'Preparing refresh for roundcube credentials', OCP\Util::DEBUG);
      $maildir = OCP\Config::getAppValue('roundcube', 'maildir', '');
      $rc_host = OCP\Config::getAppValue('roundcube', 'rcHost', OC_Request::serverHost());
      $rc_port = OCP\Config::getAppValue('roundcube', 'rcPort', '');

      OC_RoundCube_App::refresh($rc_host, $rc_port, $maildir);
    } catch (Exception $e) {
      // We got an exception == table not found
      OCP\Util::writeLog('roundcube', 'OC_RoundCube_AuthHelper.class.php: ' . 'Login error.' . $e,
                         OCP\Util::DEBUG);
      return false;
    }
  }

  public static function changePasswordListener($params)
  {
    $username = $params['uid'];
    $password = $params['password'];

    // Try to fetch from session
    $oldPrivKey = OC_RoundCube_App::getPrivateKey(false, false);
    $privKey    = OC_RoundCube_App::generateKeyPair($username, $password);
    if ($oldPrivKey !== false) {
      // Fetch credentials from data-base
      $mail_userdata_entries = OC_RoundCube_App::checkLoginData($username);
      foreach ($mail_userdata_entries as $mail_userdata) {
        $mail_username = OC_RoundCube_App::decryptMyEntry($mail_userdata['mail_user'], $privKey);
        $mail_password = OC_RoundCube_App::decryptMyEntry($mail_userdata['mail_password'], $privKey);

        $myID = $mail_userdata['id'];
        $pubKey =  OC_RoundCube_App::getPublicKey($ocuser);
        $mail_username = OC_RoundCube_App::cryptMyEntry($mail_username, $pubKey);
        $mail_password = OC_RoundCube_App::cryptMyEntry($mail_password, $pubKey);

        $stmt = OCP\DB::prepare("UPDATE *PREFIX*roundcube SET mail_user = ?, mail_password = ? WHERE id = ?");
        $result = $stmt -> execute(array($mail_username, $mail_password, $myID));
      }
    }
  }
}
?>
