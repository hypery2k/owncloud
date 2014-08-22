<?php

// Init owncloud

// Check if we are a user
OCP\User::checkAdminUser();
OCP\JSON::checkAppEnabled('roundcube');

// CSRF checks
OCP\JSON::callCheck();

$l = new OC_L10N('roundcube');

$params = array('maildir',
                'removeHeaderNav',
                'removeControlNav',
                'autoLogin',
                'enableDebug',
                'rcHost',
                'rcPort',
                'rcRefreshInterval',
                'rcNoCronRefresh');

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
      }
      if ($param === 'enableDebug') {
        OCP\Config::setAppValue('roundcube', 'enableDebug', true);
      }
      if ($param === 'rcNoCronRefresh') {
        OCP\Config::setAppValue('roundcube', 'rcNoCronRefresh', true);
      } else {
        if ($param === 'rcHost') {
          if ($_POST[$param] == '' || strlen($_POST[$param]) > 3) {
            OCP\Config::setAppValue('roundcube', $param, $_POST[$param]);
          }
        } else if ($param === 'maildir') {
          $maildir =  $_POST[$param];
          if (substr($maildir, -1) != '/') {
            $maildir .= '/';
          }
          OCP\Config::setAppValue('roundcube', $param, $maildir);
        } else if ($param == 'rcRefreshInterval') {
          $refresh = trim($_POST[$param]);
          if ($refresh == '') {
            OC_Appconfig::deleteKey('roundcube', $param);
          } else if (!is_numeric($refresh)) {
            OC_JSON::error(array(
                             "data" => array(
                               "message" => $l->t("Refresh interval '%s' is not a number.",
                                                  array($refresh)) )));
            return false;
          } else {
            OCP\Config::setAppValue('roundcube', $param, $refresh);
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
      if ($param === 'enableDebug') {
        OCP\Config::setAppValue('roundcube', 'enableDebug', false);
      }
      if ($param === 'rcNoCronRefresh') {
        OCP\Config::setAppValue('roundcube', 'rcNoCronRefresh', false);
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
