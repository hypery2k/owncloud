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

	/**
	 * @param @params array with a mutable array inside, for
	 * storing the variable-value pairs.
	 **/
	public static function jsLoadHook($params) {
		$jsAssign = &$params['array'];

		$refresh = OCP\Config::getAppValue('roundcube', 'rcRefreshInterval', 240);
		$jsAssign['Roundcube'] = 'Roundcube || {};'."\n".'Roundcube.refreshInterval = '.$refresh;
	}

	/**
	 * Login into roundcube server
	 * @param $params userdata
	 * @return true if login was succesfull otherwise false
	 */
	public static function login($params) {
		try {
			$username = $params['uid'];
			$password = $params['password'];

			OCP\Util::writeLog('roundcube', 'OC_RoundCube_AuthHelper.class.php->login(): Preparing login of user "'.$username.'" into roundcube', OCP\Util::DEBUG);

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
				
			// save login data encrypted for later usage
			$pubKey =  OC_RoundCube_App::getPublicKey($username);
			$emailUserCrypted = OC_RoundCube_App::cryptMyEntry($mail_username, $pubKey);
			$emailPasswordCrypted = OC_RoundCube_App::cryptMyEntry($mail_password, $pubKey);
			$_SESSION[OC_RoundCube_App::SESSION_ATTR_RCLOGIN] = $emailUserCrypted;
			$_SESSION[OC_RoundCube_App::SESSION_ATTR_RCPASSWORD] = $emailPasswordCrypted;
				
			// login
			OC_RoundCube_App::login($rc_host, $rc_port, $maildir, $mail_username, $mail_password);
			return true;
		} catch (Exception $e) {
			// We got an exception == table not found
			OCP\Util::writeLog('roundcube', 'OC_RoundCube_AuthHelper.class.php->login(): Login error. ' . $e,
			OCP\Util::DEBUG);
			return false;
		}
	}

	/**
	 * Logout from roundcube server to cleaning up session on OwnCloud logout
	 * @param unknown $params iserdata
	 * @return boolean true if logut was successfull, otherwise false
	 */
	public static function logout($params) {
		try {
			OCP\Util::writeLog('roundcube', 'OC_RoundCube_AuthHelper.class.php->logout(): Preparing logout of user from roundcube.', OCP\Util::DEBUG);
			$maildir = OCP\Config::getAppValue('roundcube', 'maildir', '');
			$rc_host = OCP\Config::getAppValue('roundcube', 'rcHost', OC_Request::serverHost());
			$rc_port = OCP\Config::getAppValue('roundcube', 'rcPort', '');

			OC_RoundCube_App::logout($rc_host, $rc_port, $maildir, OCP\User::getUser());
			OCP\Util::writeLog('roundcube', 'Logout of user '.OCP\User::getUser().' from roundcube done', OCP\Util::INFO);
			return true;
		} catch (Exception $e) {
			// We got an exception == table not found
			OCP\Util::writeLog('roundcube', 'OC_RoundCube_AuthHelper.class.php->logout(): Logout/Session cleaning causing errors.' . $e, OCP\Util::DEBUG);
			return false;
		}
	}

	/**
	 * Refreshs the roundcube HTTP session
	 * @return boolean true if refresh was successfull, otherwise false
	 */
	public static function refresh() {
		try {
			OCP\Util::writeLog('roundcube', 'OC_RoundCube_AuthHelper.class.php->refresh(): Preparing refresh for roundcube', OCP\Util::DEBUG);
			$maildir = OCP\Config::getAppValue('roundcube', 'maildir', '');
			$rc_host = OCP\Config::getAppValue('roundcube', 'rcHost', OC_Request::serverHost());
			$rc_port = OCP\Config::getAppValue('roundcube', 'rcPort', '');
			OC_RoundCube_App::refresh($rc_host, $rc_port, $maildir);
			OCP\Util::writeLog('roundcube', 'OC_RoundCube_AuthHelper.class.php->refresh(): Finished refresh for roundcube',
			OCP\Util::DEBUG);
			return true;
		} catch (Exception $e) {
			// We got an exception during login/refresh
			OCP\Util::writeLog('roundcube', 'OC_RoundCube_AuthHelper.class.php: ' . 'Login error during refresh.' . $e,
			OCP\Util::DEBUG);
			return false;
		}
	}

	/**
	 * listener which gets invoked if password is changed within owncloud
	 * @param unknown $params userdata
	 */
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
				OCP\Util::writeLog('roundcube', 'OC_RoundCube_AuthHelper.class.php->changePasswordListener():' . 'Updated mail password data due to password changed for user ' . $username,
				OCP\Util::DEBUG);
				$result = $stmt -> execute(array($mail_username, $mail_password, $myID));
			}
		}
	}
}
?>
