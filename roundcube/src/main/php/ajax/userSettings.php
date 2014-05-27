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

  $result = OC_RoundCube_App::cryptEmailIdentity(
    $ocUser, $_POST['mail_username'], $_POST['mail_password']);

  if ($result) {
    // update login credentials
    $maildir = OCP\Config::getAppValue('roundcube', 'maildir', '');
    $rc_host = OCP\Config::getAppValue('roundcube', 'rcHost', OC_Request::serverHost());
    $rc_port = OCP\Config::getAppValue('roundcube', 'rcPort', null);
    OC_RoundCube_App::login($rc_host, $rc_port, $maildir, $_POST['mail_username'], $_POST['mail_password']);
  } else {
    OC_JSON::error(array("data" => array( "message" => $l->t("Unable to store email credentials in the data-base.") )));
    return false;
  }
} else {
  OC_JSON::error(array("data" => array( "message" => $l->t("Not submitted for us.") )));
  return false;
}

OCP\JSON::success(array('data' => array( 'message' => $l->t('Email-user credentials successfully stored.') )));
return true;

?>
