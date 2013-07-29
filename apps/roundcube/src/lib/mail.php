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
	 * @brief check if login for the user exiss
	 * @param user object $meUser
	 * @returns a list of entries (id,mail_user,mail_password)
	 *
	 */
	public static function existLoginData($meUser) {
		OCP\Util::writeLog('roundcube', 'Checking if login data exists for ' . $meUser, OCP\Util::DEBUG);
		$stmt = OC_DB::prepare('SELECT id,mail_user,mail_password FROM *PREFIX*roundcube WHERE oc_user=?');
		$result = $stmt -> execute(array($meUser));
		$list = $result -> fetchAll();
		return $list;
	}

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
		OCP\Util::writeLog('roundcube', 'CWriting basic data for ' . $meUser, OCP\Util::DEBUG);
		$stmt = OCP\DB::prepare("INSERT INTO *PREFIX*roundcube (oc_user) VALUES (?)");
		$result = $stmt -> execute(array($meUser));
		self::checkLoginData($meUser, 1);
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
		$mailID = self::existLoginData($meUser);
		if (isset($mailID) && $mailID != '') {
			$stmt = OCP\DB::prepare("SELECT id,oc_user,mail_user,mail_password FROM *PREFIX*roundcube WHERE id = ?");
			$result = $stmt -> execute(array($mailID));
			$row = $result -> fetchRow();

			return $row;
		} elseif ($written == 0) {
			self::writeBasicData($meUser);
		}
	}

	/**
	 * @brief own cryptfunction
	 * @param object to encrypt $entry
	 * @returns encrypted entry
	 *
	 */
	public static function cryptMyEntry($entry) {

		$before = OCP\Config::getAppValue('roundcube', 'encryptstring1', '');
		$after = OCP\Config::getAppValue('roundcube', 'encryptstring2', '');
		$string = $before . $entry . $after;

		$hex = '';
		for ($i = 0; $i < strlen($string); $i++) {
			$hex .= dechex(ord($string[$i]));
		}

		return $hex;
	}

	/**
	 * @brief own cryptfunction
	 * @param object to encrypt $hex
	 * @returns decrypted entry
	 *
	 */
	public static function decryptMyEntry($hex) {
		$before = OCP\Config::getAppValue('roundcube', 'encryptstring1', '');
		$after = OCP\Config::getAppValue('roundcube', 'encryptstring2', '');
		$string = '';
		for ($i = 0; $i < strlen($hex) - 1; $i += 2) {
			$string .= chr(hexdec($hex[$i] . $hex[$i + 1]));
		}

		$string = str_replace(array($before, $after), '', $string);
		return $string;
	}

	/**
	 * TODO-hypery2k - move to template
	 *
	 * @brief showing up roundcube iFrame
	 * @param path to roundcube installation, Note: The first parameter is the URL-path of the RC inst  NOT the file-system path http://host.com/path/to/roundcube/ --> "/path/to/roundcube" $maildir
	 * @param roundcube username $ownUser
	 * @param roundcube password $ownPass
	 *
	 */
	public static function showMailFrame($maildir, $ownUser, $ownPass) {

		// Create RC login object.
		$rcl = new OC_RoundCube_Login($maildir);

		try {
			// Try to login
			OCP\Util::writeLog('roundcube', 'Trying to log into roundcube webinterface under ' . $maildir . ' as user ' . $ownUser, OCP\Util::DEBUG);
			if ($rcl -> isLoggedIn()) {
				$rcl -> logout();
				$rcl = new OC_RoundCube_Login($maildir);
			}
			if ($rcl -> login($ownUser, $ownPass)) {
				OCP\Util::writeLog('roundcube', 'Successfully logged into roundcube ', OCP\Util::DEBUG);
			} else {
				// If the login fails, display an error message in the loggs
				OCP\Util::writeLog('roundcube', 'RoundCube can\'t login to roundcube due to a login error to roundcube', OCP\Util::ERROR);
			}
			OCP\Util::writeLog('roundcube', 'Preparing iFrame for roundcube:' . $rcl -> getRedirectPath(), OCP\Util::DEBUG);
			// loader image
			$loader_image = OCP\Util::imagePath('roundcube', 'loader.gif');

			$disable_header_nav = OCP\Config::getAppValue('roundcube', 'removeHeaderNav', 'false');
			$disable_control_nav = OCP\Config::getAppValue('roundcube', 'removeControlNav', 'false');

			// create iFrame begin
			echo '<img src="' . $loader_image . '" id="loader">';
			echo '<iframe  style="display:none;overflow:auto" src="' . $rcl -> getRedirectPath() . '" id="roundcubeFrame" name="roundcube" width="100%" width="100%"> </iframe>';
			echo '<input type="hidden" id="disable_header_nav" value="' . $disable_header_nav . '"/>';
			echo '<input type="hidden" id="disable_control_nav" value="' . $disable_control_nav . '"/>';
			echo '<script type="text/javascript" src="' . OC_App::getAppWebPath('roundcube') . '/js/mailFrameScripts.js"></script>';
			// create iFrame end
		} catch (RoundcubeNetworkException $ex_net) {
			echo "ERROR: Technical problem during trying to connect to roundcube server, " . $ex_net -> getMessage();
			OCP\Util::writeLog('roundcube', 'RoundCube can\'t login to roundcube due to a network connection exception to roundcube', OCP\Util::ERROR);
			$rcl -> dumpDebugStack();
			exit ;
		} catch (OC_RoundCube_LoginException $ex_login) {
			echo "ERROR: Technical problem, " . $ex_login -> getMessage();
			OCP\Util::writeLog('roundcube', 'RoundCube can\'t login to roundcube due to a login exception to roundcube', OCP\Util::ERROR);
			$rcl -> dumpDebugStack();
			exit ;
		}

	}

}
?>
