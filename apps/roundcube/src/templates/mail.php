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
// set the passwort in session to fill the hidden login form with revertet and base64 encoded pass
// the *yourkey* must the same string as in autologin.php to replace this after revert and decode
$ocRoundCubeMailError['noUserdata'] = 'Please edit your maildata in your personal settings.';
$ocRoundCubeMailError['wrongUser'] = 'Ups we have a problem with your login. Please try again.';
$ocRoundCubeMailError['noID'] = 'Ups we have a problem with your ID. Please try again.';

$mail_userdata = OC_RoundCube_App::checkLoginData(OCP\User::getUser());
$mail_username = OC_RoundCube_App::decryptMyEntry($mail_userdata['mail_user']);
$mail_password = OC_RoundCube_App::decryptMyEntry($mail_userdata['mail_password']);

$disable_control_nav = OCP\Config::getAppValue('roundcube', 'removeControlNav', false);

if ($mail_userdata['id'] != '') {
	if ($mail_userdata['oc_user'] == OCP\User::getUser()) {
		if ($mail_username != '' && $mail_password != '') {
			$maildir = OCP\Config::getAppValue('roundcube', 'maildir', '');
			if ($maildir != '') {
                                if (OC_RoundCube_DB_Util::table_exists('roundcube')){
				if (!$disable_control_nav) {
					echo "<div class='controls' id=\"controls\"><div style=\"position: absolute;right: 13.5em;top: 0em;margin-top: 0.3em;\">" . $l -> t("Logged in as ") . $mail_username . "</div></div>";
				}
				echo "<div id='notification'></div>";
				echo "<div id='roundcube_container'>";
				OC_RoundCube_App::showMailFrame($maildir, $mail_username, $mail_password);
				echo "</div>";
                                } else {
echo $ocRoundCubeMailError['dbError'];
				echo $this -> inc("part.error.db");
}

			} else {
				echo $ocRoundCubeMailError['noUserdata'];
				echo $this -> inc("part.no-settings");
			}
		} else {
			echo $ocRoundCubeMailError['noUserdata'];
			echo $this -> inc("part.error.no-settings");
		}
	} else {
		echo $ocRoundCubeMailError['wrongUser'];
		echo $this -> inc("part.error.wrong-auth");
	}
} else {
	echo $ocRoundCubeMailError['noID'];
	echo $this -> inc("part.error.no-settings");
}
?>
