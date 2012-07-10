<?php
/**
* ownCloud - roundcube mail plugin
*
* @author Martin Reinhardt
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

$mailuserdata = OC_RoundCube_App::checkLoginData(OC_User::getUser());
$mailUsername = OC_RoundCube_App::decryptMyEntry($mailuserdata['mailUser']);
$mailPassword = OC_RoundCube_App::decryptMyEntry($mailuserdata['mailPass']);
?>

<form id="usermail" action="#" method="post">
	<fieldset class="personalblock">
		<legend><strong><?php echo $l->t('RoundCube Mailaccount');?></strong></legend>
        <p>
        	<label for="usermail"><?php echo $l->t('Username');?>
        		<input type="text" id="mailUsername" name="mailUsername" value="<?php echo $mailUsername;?>">
        	</label>
        	<label for="usermail"><?php echo $l->t('Password');?>
        		<input type="password" id="mailPassword" name="mailPassword" value="<?php echo $mailPassword;?>">
        	</label></p>
        <input type="submit" value="Save" />
	</fieldset>
</form>