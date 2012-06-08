<?php
/**
* ownCloud - roundcube mail plugin
*
* @author Martin Reinhardt
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
$ocRoundCubeMailError['noID'] = 'Ups we have a problem with your login. Please try again.';


$mailuserdata = OC_RoundCubeMail_App::checkLoginData(OC_User::getUser());
$mailUsername = OC_RoundCubeMail_App::decryptMyEntry($mailuserdata['mailUser']);
$mailPassword = OC_RoundCubeMail_App::decryptMyEntry($mailuserdata['mailPass']);

if ($mailuserdata['id'] != '') {
	if($mailuserdata['ocUser'] == OC_User::getUser()) {
		if ($mailuserdata['mailUser'] != '' && $mailuserdata['mailPass'] != '') {
			$maildir = OC_Appconfig::getValue('roundcube', 'maildir','');
			OC_RoundCubeMail_App::showMailFrame($maildir, $mailUsername, $mailPassword);
		}
		else echo $ocRoundCubeMailError['noUserdata'];
	}
	else echo $ocRoundCubeMailError['wrongUser'];
}
else echo $ocRoundCubeMailError['noID'];


?>