<?php

//update from old app version

$installedVersion = OCP\Config::getAppValue('storagecharts2', 'installed_version');
if (version_compare($installedVersion, '2.4', '<')) {
	try {
		$sql1 = 'ALTER TABLE `*PREFIX*storagecharts2` CHANGE COLUMN `stc_month` `stc_month` FLOAT NOT NULL DEFAULT 0';
		$args = array(1);
		$query1 = \OCP\DB::prepare($sql1);
		$result1 = $query1->execute($args);
		$sql2 = 'ALTER TABLE `*PREFIX*storagecharts2` CHANGE COLUMN `stc_dayts` `stc_day` FLOAT NOT NULL DEFAULT 0';
		$query2 = \OCP\DB::prepare($sql2);
		$result2 = $query2->execute($args);
		$sql3 = 'ALTER TABLE `*PREFIX*storagecharts2` CHANGE COLUMN `stc_used` `stc_used` FLOAT NOT NULL DEFAULT 0';
		$query3 = \OCP\DB::prepare($sql3);
		$result3 = $query3->execute($args);
		$sql4 = 'ALTER TABLE `*PREFIX*storagecharts2` CHANGE COLUMN `stc_total` `stc_total` FLOAT NOT NULL DEFAULT 0';
		$query4 = \OCP\DB::prepare($sql4);
		$result4 = $query4->execute($args);
	} catch (Exception $e) {
		// We got an exception == table not found
		OCP\Util::writeLog('storagecharts2', 'update.php: ' . 'update error. ' . $e, OCP\Util::DEBUG);
	}

}
