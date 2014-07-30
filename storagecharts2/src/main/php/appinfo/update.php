<?php

//update from old app version

$installedVersion = OCP\Config::getAppValue('storagecharts2', 'installed_version');
if (version_compare($installedVersion, '2.5.0', '<')) {
	try {
		$sql = 'ALTER TABLE `*PREFIX*storagecharts2` CHANGE COLUMN `?` `?` FLOAT NOT NULL DEFAULT 0.0';
		$query = \OCP\DB::prepare($sql);
		$result1 = $query->execute(array( 'stc_month', 'stc_month' ) );
		$result2 = $query->execute(array( 'stc_dayts', 'stc_day' ) );
		$result3 = $query->execute(array( 'stc_used', 'stc_used' ) );
		$result4 = $query->execute(array( 'stc_total', 'stc_total' ) );
	} catch (Exception $e) {
		// We got an exception == table not found
		OCP\Util::writeLog('storagecharts2', 'update.php: ' . 'update error. ' . $e, OCP\Util::DEBUG);
	}

}

?>