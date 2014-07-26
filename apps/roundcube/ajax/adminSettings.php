<?php

// Init owncloud

// Check if we are a user
OCP\User::checkAdminUser();
OCP\JSON::checkAppEnabled('roundcube');
OCP\JSON::callCheck();
$l = new OC_L10N('roundcube');

$params = array(
  'maildir' => true,
  'removeHeaderNav' => 'checkbox',
  'removeControlNav' => 'checkbox',
  'autoLogin' => 'checkbox',
  'noDebug' => 'checkbox',
  'rcHost' => function ($value) { return strlen($value) > 3; }
  );

if (isset($_POST['appname']) && $_POST['appname'] == "roundcube") {
  foreach ($params as $param => $constraint) {
    if (isset($_POST[$param])) {
      if ($constraint === 'checkbox') {
        OCP\Config::setAppValue('roundcube', $param, true);
      } else if ($constraint === true) {
        OCP\Config::setAppValue('roundcube', $param, $_POST[$param]);
      } else if (is_callable($constraint) &&
                 call_user_func($constraint, $_POST[$param])) {
        OCP\Config::setAppValue('roundcube', $param, $_POST[$param]);
      }
    } else if ($constraint == 'checkbox') {
      OCP\Config::setAppValue('roundcube', $param, false);
    }
  }
} else {
  OC_JSON::error(array("data" => array( "message" => $l->t("Not submitted for us.") )));
  return false;
}

OCP\JSON::success(array('data' => array( 'message' => $l->t('Application settings successfully stored.') )));
return true;

?>
