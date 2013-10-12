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

OCP\App::checkAppEnabled('storage-charts');

OC::$CLASSPATH['OC_DLStCharts'] = OC_App::getAppPath('storage-charts') . "/lib/db.class.php";
OC::$CLASSPATH['OC_DLStChartsLoader'] = OC_App::getAppPath('storage-charts') . "/lib/loader.class.php";

OCP\App::register(Array(
	'order' => 60,
	'id' => 'storage-charts',
	'name' => 'Storage Charts'
));

OCP\App::addNavigationEntry(Array(
	'id' => 'storage-charts',
	'order' => 60,
	'href' => OCP\Util::linkTo('storage-charts', 'charts.php'),
	'icon' => OCP\Util::imagePath('storage-charts', 'chart.png'),
	'name' => 'DL Charts'
));

OCP\App::registerPersonal('storage-charts','settings');

$data_dir = OCP\Config::getSystemValue('datadirectory', '');
if(OCP\User::getUser() && strlen($data_dir) != 0){
	$fs = OCP\Files::getStorage('files');
	$used = OC_DLStCharts::getTotalDataSize(OC::$CONFIG_DATADIRECTORY);
	$total = OC_DLStCharts::getTotalDataSize($data_dir) + $fs->free_space();
	OC_DLStCharts::update($used, $total);
}
