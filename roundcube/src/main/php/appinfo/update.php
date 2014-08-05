<?php

//update from old app version

$installedVersion = OCP\Config::getAppValue('roundcube', 'installed_version');
if (version_compare($installedVersion, '2.2', '<')) {
	try {
		$sql = 'DELETE FROM `*PREFIX*appconfig` WHERE appid = roundcube AND configkey = mail_username';
		$args = array(1);
		$query = \OCP\DB::prepare($sql);
		$result = $query->execute($args);
	} catch (Exception $e) {
		// We got an exception == table not found
		OCP\Util::writeLog('roundcube', 'update.php: ' . 'update error. ' . $e,
		OCP\Util::DEBUG);
	}

}
