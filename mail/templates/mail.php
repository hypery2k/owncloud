<?php
// set the passwort in session to fill the hidden login form with revertet and base64 encoded pass
// the *yourkey* must the same string as in autologin.php to replace this after revert and decode
$ocMailError['noUserdata'] = 'Please edit your maildata in your personal settings.';
$ocMailError['wrongUser'] = 'Ups we have a problem with your login. Please try again.';
$ocMailError['noID'] = 'Ups we have a problem with your login. Please try again.';


$mailuserdata = OC_Mail_App::checkLoginData(OC_User::getUser());
$mailUsername = OC_Mail_App::decryptMyEntry($mailuserdata['mailUser']);
$mailPassword = OC_Mail_App::decryptMyEntry($mailuserdata['mailPass']);

if ($mailuserdata['id'] != '') {
	if($mailuserdata['ocUser'] == OC_User::getUser()) {
		if ($mailuserdata['mailUser'] != '' && $mailuserdata['mailPass'] != '') {
			$maildir = OC_Appconfig::getValue('mail', 'maildir','');
			OC_Mail_App::showMailFrame($maildir, $mailUsername, $mailPassword);
		}
		else echo $ocMailError['noUserdata'];
	}
	else echo $ocMailError['wrongUser'];
}
else echo $ocMailError['noID'];


?>