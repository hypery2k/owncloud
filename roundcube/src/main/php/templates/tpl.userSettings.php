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

$ocVersion = $_['ocVersion'];
$cfgClass = $ocVersion >= 7 ? 'section' : 'personalblock';

$table_exists = OC_RoundCube_DB_Util::tableExists();

if (!$table_exists) {
	OCP\Util::writeLog('roundcube', 'DB table entries do not exist ...', OCP\Util::ERROR);
	echo $this -> inc("part.error.db");
} else {
	$mail_userdata_entries = OC_RoundCube_App::checkLoginData(OCP\User::getUser());
	?>
<form id="rc_mail_settings" action="#"
	method="post">
	<!-- Prevent CSRF attacks-->
	<input type="hidden" name="requesttoken"
		value="<?php echo $_['requesttoken'] ?>" id="requesttoken"> <input
		type="hidden" name="appname" value="roundcube">
	<fieldset class="<?php echo $cfgClass; ?>" id="roundcube">
		<h2>
			<?php p($l->t('RoundCube Mailaccount')); ?>
		</h2>
		<?php	
		$enable_auto_login = OCP\Config::getAppValue('roundcube', 'autoLogin', false);
		if(!$enable_auto_login){
		    $username = OCP\User::getUser();
		    foreach($mail_userdata_entries as $mail_userdata) {
		        $mail_username = isset($_SESSION[OC_RoundCube_App::SESSION_ATTR_RCUSER])?$_SESSION[OC_RoundCube_App::SESSION_ATTR_RCUSER]:'';
		        $mail_password = '';
		        // TODO use template and add button for adding entries
		        ?>
		<input type="text" id="rc_mail_username" name="rc_mail_username"
			value="<?php echo $mail_username; ?>"
			placeholder="<?php p($l -> t('Email Login Name')); ?>" /> <input
			type="password" id="rc_mail_password" name="rc_mail_password"
			placeholder="<?php p($l -> t('Email Password')); ?>"
			data-typetoggle="rc_mail_password_show" /> <input type="button"
			value="<?php p($l -> t('Update Email Identity')); ?>"
			name="rc_usermail_update" id="rc_usermail_update" />

		<div id="rc_usermail_update_message" class="statusmessage">
			<?php p($l->t('Saving...')); ?>
		</div>
		<div id="rc_usermail_success_message" class="successmessage"></div>
		<div id="rc_usermail_error_message" class="errormessage">
			<?php p($l -> t('General saving error occurred.')); ?>
		</div>
		<div id="rc_usermail_error_empty_message" class="errormessage">
			<?php p($l -> t('Please fill username and password fields')); ?>
		</div>
		<?php
		   }
		} else {
		    p($l -> t('Autologin for users activated. OwnCloud user data will be used for login in roundcube'));
		}
		?>
	</fieldset>
</form>
<?php
}
