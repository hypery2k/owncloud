<?php

/**
 * OwnCloud - Storage Charts plugin
 *
 * @author Martin Reinhardt and Xavier Beurois
 * @copyright 2012 Xavier Beurois www.djazz-lab.net and Martin Reinhardt contact@martinreinhardt-online.de
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU AFFERO GENERAL PUBLIC LICENSE
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU AFFERO GENERAL PUBLIC LICENSE for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

OCP\App::checkAppEnabled('storagecharts2');

$l = new OC_L10N('storagecharts2');

OC::$CLASSPATH['OC_DLStCharts'] =  OC_App::getAppPath('storagecharts2') . "/lib/db.class.php";
OC::$CLASSPATH['OC_DLStChartsLoader'] =  OC_App::getAppPath('storagecharts2') . "/lib/loader.class.php";

OCP\App::addNavigationEntry(array(
	'id' => 'storagecharts2_index',
	'order' => 60,
	'href' => OCP\Util::linkTo('storagecharts2', 'index.php'),
	'icon' => OCP\Util::imagePath('storagecharts2', 'chart.svg'),
	'name' => $l->t('Storage Charts')
));

OCP\App::registerPersonal('storagecharts2','settings');

// Get storage value for logged in user
$data_dir = OCP\Config::getSystemValue('datadirectory', '');
if(OCP\User::getUser() && strlen($data_dir) != 0){
	$fs = OCP\Files::getStorage('files');

	// workaround to detect OC version
	// OC 5
	if (6 > @reset(OCP\Util::getVersion())) {
		OCP\Util::writeLog('storagecharts2', 'Running on OwnCloud 5', OCP\Util::DEBUG);
		$used = OC_DLStCharts::getTotalDataSize(OC::$CONFIG_DATADIRECTORY);
		// OC 6
	} else {
		$datadir = OC_Config::getValue('datadirectory');
		OCP\Util::writeLog('storagecharts2', 'Running on OwnCloud 6', OCP\Util::DEBUG);
		$used = OC_DLStCharts::getTotalDataSize($datadir);
	}
	$total = OC_DLStCharts::getTotalDataSize($data_dir) + $fs->free_space();
	OC_DLStCharts::update($used, $total);
}
