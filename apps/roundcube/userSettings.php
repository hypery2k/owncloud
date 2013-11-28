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

// CSRF checks
if ($_POST) {
  OCP\JSON::callCheck();
}

if (isset($_POST['appname']) && $_POST['appname'] == "roundcube") {
  $ocuser = OCP\User::getUser();
  $mail_userdata_entries = OC_RoundCube_App::checkLoginData($ocuser);
  // TODO multiple user support
  $mail_userdata = $mail_userdata_entries[0];
  $myID = $mail_userdata['id'];
  $pubKey =  OC_RoundCube_App::getPublicKey($ocuser);
  $mail_user = OC_RoundCube_App::cryptMyEntry($_POST['mail_username'], $pubKey);
  $mail_password = OC_RoundCube_App::cryptMyEntry($_POST['mail_password'], $pubKey);

  $stmt = OCP\DB::prepare("UPDATE *PREFIX*roundcube SET mail_user = ?, mail_password = ? WHERE id = ?");
  $result = $stmt -> execute(array($mail_user, $mail_password, $myID));

  if ($result) {
    // update login credentials
    $maildir = OCP\Config::getAppValue('roundcube', 'maildir', '');
    $rc_host = OCP\Config::getAppValue('roundcube', 'rcHost', OC_Request::serverHost());
    OC_RoundCube_App::login($rc_host, $maildir, $_POST['mail_username'], $_POST['mail_password']);
  }
}

// fill template
$params = array();
$tmpl = new OCP\Template('roundcube', 'userSettings');
foreach ($params as $param) {
  $value = OCP\Config::getAppValue('roundcube', $param, '');
  $tmpl -> assign($param, $value);
}
return $tmpl -> fetchPage();
?>
