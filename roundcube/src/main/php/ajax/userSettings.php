<?php

// Init owncloud

// Check if we are a user
OCP\JSON::checkLoggedIn();
OCP\JSON::checkAppEnabled('roundcube');

// CSRF checks
OCP\JSON::callCheck();

$l = new OC_L10N('roundcube');

if (isset($_POST['appname']) && $_POST['appname'] == "roundcube") {
	$ocUser = OCP\User::getUser();

	$result = OC_RoundCube_App::cryptEmailIdentity($ocUser, $_POST['rc_mail_username'], $_POST['rc_mail_password'], true);

	if ($result) {
		// update login credentials
		$maildir = OCP\Config::getAppValue('roundcube', 'maildir', '');
		$rc_host = OCP\Config::getAppValue('roundcube', 'rcHost', '');
		if ($rc_host == '') {
			$rc_host = OC_Request::serverHost();
		}
		$params= array(
				"uid" => $_POST['rc_mail_username'],
				"password" => $_POST['rc_mail_password'],
		);
		// first logout
		// then login again
		OC_RoundCube_AuthHelper::logout($params);
		// then login again
		OC_RoundCube_AuthHelper::login($params);
	} else {
		OC_JSON::error(array("data" => array( "message" => $l->t("Unable to store email credentials in the data-base.") )));
		return false;
	}
} else {
	OC_JSON::error(array("data" => array( "message" => $l->t("Not submitted for us.") )));
	return false;
}

OCP\JSON::success(array('data' => array( 'message' => $l->t('Email-user credentials successfully stored. Please login again to OwnCloud for applying the new settings.') )));
return true;
