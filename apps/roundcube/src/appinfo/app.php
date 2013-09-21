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

$l = new OC_L10N('roundcube');
OC::$CLASSPATH['OC_Mail_NetworkingException'] = OC_App::getAppPath('roundcube') . '/lib/MailNetworkException.class.php';
OC::$CLASSPATH['OC_Mail_LoginException'] = OC_App::getAppPath('roundcube') . '/lib/MailLoginException.class.php';
OC::$CLASSPATH['OC_Mail_RC_InstallNotFoundException'] = OC_App::getAppPath('roundcube') . '/lib/MailRoundcubeNotFoundException.class.php';

OC::$CLASSPATH['OC_Mail_Object'] = OC_App::getAppPath('roundcube') . '/lib/MailObject.class.php';

OC::$CLASSPATH['OC_RoundCube_App'] = OC_App::getAppPath('roundcube') . '/lib/RoundcubeApp.class.php';
OC::$CLASSPATH['OC_RoundCube_DB_Util'] = OC_App::getAppPath('roundcube') . '/lib/RoundCubeDBUtil.class.php';
OC::$CLASSPATH['OC_RoundCube_Login'] = OC_App::getAppPath('roundcube') . '/lib/RoundcubeLogin.class.php';
OC::$CLASSPATH['OC_RoundCube_AuthHelper'] = OC_App::getAppPath('roundcube') . '/lib/RoundcubeAuthHelper.class.php';

$enable_auto_login = OCP\Config::getAppValue('roundcube', 'autoLogin', false);

if ($enable_auto_login) {
	OCP\Util::connectHook('OC_User', 'post_login', 'OC_RoundCube_AuthHelper', 'autoSave');
	OCP\Util::connectHook('OC_User', 'logout', 'OC_RoundCube_AuthHelper', 'logout');
}

OCP\App::registerAdmin('roundcube', 'adminSettings');
OCP\App::registerPersonal('roundcube', 'userSettings');

OCP\App::addNavigationEntry(array(
		'id' => 'roundcube_index', 
		'order' => 10, 
		'href' => OCP\Util::linkTo('roundcube', 'index.php'), 
		'icon' => OCP\Util::imagePath('roundcube', 'mail.png'), 
		'name' => $l -> t('Webmail'))
);
?>
