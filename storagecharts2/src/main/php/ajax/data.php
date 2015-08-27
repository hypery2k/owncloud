<?php

/**
* ownCloud - DjazzLab Storage Charts plugin
*
* @author Xavier Beurois
* @copyright 2012 Xavier Beurois www.djazz-lab.net
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

OCP\JSON::checkLoggedIn();

$l = new OC_L10N('storagecharts2');

// build user list
$uids = OCP\User::getUsers();
$users = array();
foreach ($uids as $user) {
    array_push($users,'{"name":"' . $user . '","displayName":"'.OCP\User::getDisplayName($user).'"}');
}

if (array_key_exists('s',$_POST) && array_key_exists('k',$_POST) && 
    is_numeric($_POST['s']) && in_array($_POST['k'], Array('hu_size','hu_size_hus','hu_ratio'))){
    // Update and save the new configuration
	OC_DLStCharts::setUConfValue($_POST['k'], $_POST['s']);
	switch($_POST['k']){
		case 'hu_size':
			OCP\JSON::encodedPrint(Array('data' => Array(
			'chart' => OC_DLStChartsLoader::loadChart('chisto_us', $l),			
			'users' => $users)));
			break;
		case 'hu_size_hus':
			OCP\JSON::encodedPrint(Array('data' => Array(
			'chart' => OC_DLStChartsLoader::loadChart('clines_usse', $l),			
			'users' => $users)));
			break;
	}
} else {
	// default
	OCP\JSON::encodedPrint(Array('data' => Array(
	       'chart' => OC_DLStChartsLoader::loadChart('cpie_rfsus', $l),			
		   'users' => $users)));
}


