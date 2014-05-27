<?php

// Init owncloud

// Check if we are a user
OCP\User::checkAdminUser();
OCP\JSON::checkAppEnabled('roundcube');

// CSRF checks
OCP\JSON::callCheck();

$l = new OC_L10N('roundcube');

$params = array('maildir', 'removeHeaderNav', 'removeControlNav', 'autoLogin', 'enableDebug', 'rcHost', 'rcPort');

if (isset($_POST['appname']) && $_POST['appname'] == "roundcube") {
  foreach ($params as $param) {
    if (isset($_POST[$param])) {
      if ($param === 'removeHeaderNav') {
        OCP\Config::setAppValue('roundcube', 'removeHeaderNav', true);
      }
      if ($param === 'removeControlNav') {
        OCP\Config::setAppValue('roundcube', 'removeControlNav', true);
      }
      if ($param === 'autoLogin') {
        OCP\Config::setAppValue('roundcube', 'autoLogin', true);
      } else {
        if ($param === 'rcHost') {
          if (strlen($_POST[$param]) > 3) {
            OCP\Config::setAppValue('roundcube', $param, $_POST[$param]);
          }
        } else {
          OCP\Config::setAppValue('roundcube', $param, $_POST[$param]);
        }
      }
    } else {
      if ($param === 'removeHeaderNav') {
        OCP\Config::setAppValue('roundcube', 'removeHeaderNav', false);
      }
      if ($param === 'removeControlNav') {
        OCP\Config::setAppValue('roundcube', 'removeControlNav', false);
      }
      if ($param === 'autoLogin') {
        OCP\Config::setAppValue('roundcube', 'autoLogin', false);
      }
    }
  }
  // update login status
  $username = OCP\User::getUser();
  $params = array("uid" => $username);
  $loginHelper = new OC_RoundCube_AuthHelper();
  $loginHelper->login($params);
} else {
  OC_JSON::error(array("data" => array( "message" => $l->t("Not submitted for us.") )));
  return false;
}

OCP\JSON::success(array('data' => array( 'message' => $l->t('Application settings successfully stored.') )));
return true;

?>
