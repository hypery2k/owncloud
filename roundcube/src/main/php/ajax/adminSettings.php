<?php

// Init owncloud

// Check if we are a user
OCP\User::checkAdminUser();

// CSRF checks
OCP\JSON::callCheck();

// workaround to detect OC version and compatibility for OC and nextcloud
$ocVersion = OCP\Util::getVersion();


if ($ocVersion < 9) {
	$l = new OC_L10N('roundcube');
} else {
	$l = OC::$server->getL10N('roundcube');
}

$params = array('maildir', 'removeHeaderNav', 'removeControlNav', 'autoLogin', 'noSSLverify', 'enableDebug', 'rcHost', 'rcPort', 'rcInternalAddress', 'rcRefreshInterval');

if (isset($_POST['appname']) && $_POST['appname'] == "roundcube") {
	foreach ($params as $param) {
		if (isset($_POST[$param])) {
			if ($param === 'noSSLverify') {
				OCP\Config::setAppValue('roundcube', 'noSSLverify', false);
			}
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
			if ($param === 'rcInternalAddress') {
				if ($_POST[$param] == '' || strpos($_POST[$param], '://') > -1) {
					OCP\Config::setAppValue('roundcube', 'rcInternalAddress', true);
				} else {
					OC_JSON::error(array(
						"data" => array(
							"message" => $l->t("Internal address '%s' is not an URL",
								array($_POST[$param])
							)
						)
					));
				}
			}
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
					if ($ocVersion < 9) {
						OC_Appconfig::deleteKey('roundcube', $param);
					} else {
						\OCP\Util::connectHook('OC_Appconfig', 'deleteKey', 'roundcube', $param);
					}
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

OC_JSON::success(array('data' => array( 'message' => $l->t('Application settings successfully stored.') )));
return true;
