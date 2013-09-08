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

	public static function autoSave($params) {
		$mail_userdata_entries = OC_RoundCube_App::checkLoginData(OCP\User::getUser());
		// TODO add multi-user support
		$myID = $mail_userdata_entries[0];
		$mail_user = OC_RoundCube_App::cryptMyEntry($params['uid']);
		$mail_password = OC_RoundCube_App::cryptMyEntry($params['password']);
		$stmt = OCP\DB::prepare("UPDATE *PREFIX*roundcube SET mail_user = ?, mail_password = ? WHERE id = ?");
		$result = $stmt -> execute(array($mail_user, $mail_password, $myID));
	}

	public static function logout($params) {
		$maildir = OCP\Config::getAppValue('roundcube', 'maildir', '');
		OC_RoundCube_App::logout($maildir, OCP\User::getUser());
	}

}
?>