<?php
/**
 * ownCloud - roundcube mail plugin
 *
 \* @author Martin Reinhardt and David Jaedke
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

$mail_userdata_entries = OC_RoundCube_App::checkLoginData(OCP\User::getUser());

foreach($mail_userdata_entries as $mail_userdata) {

?>

<form id="usermail" action="#" method="post">
		<!-- Prevent CSRF attacks-->
	<input type="hidden" name="requesttoken" value="<?php echo $_['requesttoken'] ?>" id="requesttoken">
	<fieldset class="personalblock">
	<legend><strong><?php echo $l -> t('RoundCube Mailaccount'); ?></strong></legend>
    <p>
<?php
$mail_username = OC_RoundCube_App::decryptMyEntry($mail_userdata['mail_user']);
$mail_passwordword = OC_RoundCube_App::decryptMyEntry($mail_userdata['mail_password']);
// TODO use template and add button for adding entries
?>	
		<label for="usermail"><?php echo $l -> t('Username'); ?>
			<input type="text" id="mail_username" name="mail_username" value="<?php echo $mail_username; ?>">
		</label>
		<label for="usermail"><?php echo $l -> t('Password'); ?>
			<input type="password" id="mail_passwordword" name="mail_passwordword" value="<?php echo $mail_passwordword; ?>">
		</label>

<?php
}
?>	
	</p>
    <input type="submit" value="Save" />
</fieldset>
</form>
