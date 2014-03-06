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

$table_exists = OC_RoundCube_DB_Util::tableExists();

if (!$table_exists) {
  OCP\Util::writeLog('roundcube', 'DB table entries do not exist ...', OCP\Util::ERROR);
  echo $this -> inc("part.error.db");
} else {  
$mail_userdata_entries = OC_RoundCube_App::checkLoginData(OCP\User::getUser());
?>
<form id="usermail" action="#" method="post">
    <!-- Prevent CSRF attacks-->
  <input type="hidden" name="requesttoken" value="<?php echo $_['requesttoken'] ?>" id="requesttoken">
  <input type="hidden" name="appname" value="roundcube">
  <fieldset class="personalblock" id="roundcube">
  <h2><?php p($l->t('RoundCube Mailaccount')); ?></h2>
    <p>
<?php
$username = OCP\User::getUser();
$privKey = OC_RoundCube_App::getPrivateKey($username, false);
foreach($mail_userdata_entries as $mail_userdata) {
    $mail_username = OC_RoundCube_App::decryptMyEntry($mail_userdata['mail_user'], $privKey);
    $mail_password = OC_RoundCube_App::decryptMyEntry($mail_userdata['mail_password'], $privKey);
    // TODO use template and add button for adding entries
    ?>
        <input type="text"
            id="mail_username"
              name="mail_username"
              value="<?php echo $mail_username; ?>"
              placeholder="<?php p($l -> t('Email Login Name')); ?>"
              />
        <input type="password"
                 id="mail_password"
                 name="mail_password"
                 placeholder="<?php p($l -> t('Email Password')); ?>"
                 data-typetoggle="#mail_password_show"/>
        <input type="checkbox" id="mail_password_show" name="show" />
        <label for="mail_password_show"><?php p($l -> t('show')); ?></label>
        <input type="button"
               value="<?php p($l -> t('Change Email Identity')); ?>"
               name="usermail_update"
               id="usermail_update"/>
        <div class="statusmessage" id="usermail_update_message"></div>
    <?php
}
?>
</fieldset>
</form>
<?php
}
?>