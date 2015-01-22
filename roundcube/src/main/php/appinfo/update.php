<?php

//update from old app version, cleaning up old parameters

$installedVersion = OCP\Config::getAppValue('roundcube', 'installed_version');
if (version_compare($installedVersion, '2.5.4', '<')) {
	try {
		$sql = 'DELETE FROM `*PREFIX*appconfig` WHERE appid = roundcube AND configkey = rcNoCronRefresh';
		$args = array(1);
		$query = \OCP\DB::prepare($sql);
		$result = $query->execute($args);
	} catch (Exception $e) {
		// We got an exception == table not found
		OCP\Util::writeLog('roundcube', 'update.php: ' . 'update error for removing rcNoCronRefresh. ' . $e,
		OCP\Util::DEBUG);
	}
	try {
		$sql = 'DELETE FROM `*PREFIX*appconfig` WHERE appid = roundcube AND configkey = encryptstring1';
		$args = array(1);
		$query = \OCP\DB::prepare($sql);
		$result = $query->execute($args);
	} catch (Exception $e) {
		// We got an exception == table not found
		OCP\Util::writeLog('roundcube', 'update.php: ' . 'update error for removing encryptstring1. ' . $e,
		OCP\Util::DEBUG);
	}
	try {
		$sql = 'DELETE FROM `*PREFIX*appconfig` WHERE appid = roundcube AND configkey = encryptstring1';
		$args = array(1);
		$query = \OCP\DB::prepare($sql);
		$result = $query->execute($args);
	} catch (Exception $e) {
		// We got an exception == table not found
		OCP\Util::writeLog('roundcube', 'update.php: ' . 'update error for removing encryptstring1. ' . $e,
		OCP\Util::DEBUG);
	}
	try {
		$sql = 'DELETE FROM `*PREFIX*appconfig` WHERE appid = roundcube AND configkey = mail_username';
		$args = array(1);
		$query = \OCP\DB::prepare($sql);
		$result = $query->execute($args);
	} catch (Exception $e) {
		// We got an exception == table not found
		OCP\Util::writeLog('roundcube', 'update.php: ' . 'update error for removing mail_username. ' . $e,
		OCP\Util::DEBUG);
	}
}
