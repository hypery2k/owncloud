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


OCP\JSON::checkLoggedIn();
OCP\JSON::checkAppEnabled('roundcube');

$table_exists = OC_RoundCube_DB_Util::tableExists();

$html_output = "";
if (!$table_exists) {
	OCP\Util::writeLog('roundcube', 'tpl.mail.php: DB table entries not created ...', OCP\Util::INFO);
	$html_output = $html_output . $this -> inc("part.error.db");
} else {
	$ocUser = OCP\User::getUser();
	$privKey = OC_RoundCube_App::getPrivateKey($ocUser,false);
	$mail_userdata_entries = OC_RoundCube_App::checkLoginData(OCP\User::getUser());
	// TODO create dropdown list
	$mail_userdata = $mail_userdata_entries[0];

	//
	// Nope. Already logged in at the start. Then starting to support
	// multiple accounts, a re-login with other credentials than the
	// default ID could be provided.
	//

	$disable_control_nav = OCP\Config::getAppValue('roundcube', 'removeControlNav', false);
	$enable_autologin = OCP\Config::getAppValue('roundcube', 'autoLogin', false);

	$maildir = OCP\Config::getAppValue('roundcube', 'maildir', '');
	$rc_host = OCP\Config::getAppValue('roundcube', 'rcHost', '');
	if ($rc_host == '') {
		$rc_host = OC_Request::serverHost();
	}
	$rc_port = OCP\Config::getAppValue('roundcube', 'rcPort', null);

	OCP\Util::writeLog('roundcube', 'tpl.mail.php: Opening iframe for RC-host '.$rc_host.' with port '.$rc_port, OCP\Util::DEBUG);

	OCP\Util::writeLog('roundcube', 'tpl.mail.php: Preparing pre-check before rendering mail view ', OCP\Util::INFO);
	if ($mail_userdata['id'] != '') {
		if ($mail_userdata['oc_user'] == OCP\User::getUser()) {
			if (!$enable_autologin && empty($mail_userdata)) {
				OCP\Util::writeLog('roundcube', 'tpl.mail.php: No valid user login data found.', OCP\Util::ERROR);
				$html_output = $html_output . $this -> inc("part.error.no-settings");
			}
			else {
				OCP\Util::writeLog('roundcube', 'tpl.mail.php: Found valid user login data.', OCP\Util::DEBUG);
				if ($maildir != '') {
					$mailAppReturn = OC_RoundCube_App::showMailFrame($rc_host, $rc_port, $maildir);
					if ($mailAppReturn -> isErrorOccurred()) {
						OCP\Util::writeLog('roundcube', 'Not rendering roundcube iframe view due to errors', OCP\Util::ERROR);
						OCP\Util::writeLog('roundcube', 'Got the following error code: '.$mailAppReturn -> getErrorCode(),OCP\Util::ERROR);
						switch ($mailAppReturn -> getErrorCode()) {
							case OC_Mail_Object::ERROR_CODE_NETWORK :
								$html_output = $this -> inc("part.error.error-settings");
								$html_output = $html_output . $mailAppReturn -> getErrorDetails();
								break;
							case OC_Mail_Object::ERROR_CODE_LOGIN :
								$html_output = $this -> inc("part.error.wrong-auth");
								$html_output = $html_output . $mailAppReturn -> getErrorDetails();
								break;
							case OC_Mail_Object::ERROR_CODE_RC_NOT_FOUND :
								$html_output = $this -> inc("part.error.error-settings");
								$html_output = $html_output . $mailAppReturn -> getErrorDetails();
								break;
							default :
								$html_output = $this -> inc("part.error.error-settings");
								$html_output = $html_output . $mailAppReturn -> getErrorDetails();
								break;
						}
					} else {
						OCP\Util::writeLog('roundcube', 'Rendering roundcube iframe view', OCP\Util::INFO);
						if (!$disable_control_nav) {
							$html_output = $html_output . "<div class=\"mail-controls\" id=\"mail-control-bar\"><div style=\"position: absolute;right: 13.5em;top: 0em;margin-top: 0.3em;\">" . $l -> t("Logged in as ") .$mailAppReturn->getDisplayName(). "</div></div>";
						}
						$html_output = $html_output . "<div id=\"notification\"></div>";
						if (!$disable_control_nav) {
							$html_output = $html_output . "<div id=\"roundcube_container\" style=\"top: 5.5em;\">";
						} else {
							$html_output = $html_output . "<div id=\"roundcube_container\" >";
						}
						$html_output = $html_output . $mailAppReturn -> getHtmlOutput();
						$html_output = $html_output . "</div>";

					}

				} else {
					OCP\Util::writeLog('roundcube', 'roundcube server path not set',OCP\Util::ERROR);
					$html_output = $html_output . $this -> inc("part.error.no-settings");
				}
			}
		} else {
	  OCP\Util::writeLog('roundcube', 'No user login data set',OCP\Util::ERROR);
	  $html_output = $html_output . $this -> inc("part.error.wrong-auth");
		}
	} else {
		OCP\Util::writeLog('roundcube', 'No user id set',OCP\Util::ERROR);
		if($enable_autologin){
			$html_output = $html_output . $this -> inc("part.error.autologin");
		} else {
			$html_output = $html_output . $this -> inc("part.error.no-settings");
		}
	}
}
// output formatted HTML
echo $html_output;
