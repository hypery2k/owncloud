<?php

/**
* ownCloud - roundcube mail plugin
*
* @author Martin Reinhardt and David Jaedke
* @copyright 2012 Martin Reinhardt contact@martinreinhardt-online.de
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
if ($_POST) {
	$myID = OC_RoundCube_App::existLoginData(OCP\User::getUser());
	$mail_user = OC_RoundCube_App::cryptMyEntry($_POST['mail_username']);
	$mail_password = OC_RoundCube_App::cryptMyEntry($_POST['mail_passwordword']);
	$stmt = OCP\DB::prepare("UPDATE *PREFIX*roundcube SET mail_user = '$mail_user', mail_password = '$mail_password' WHERE id = $myID");
	$result = $stmt->execute();
}

// fill template
$tmpl = new OCP\Template( 'roundcube', 'userSettings');
foreach($params as $param){
                $value = OCP\Config::getAppValue('roundcube', $param,'');
                $tmpl->assign($param, $value);
}
return $tmpl->fetchPage();
?>