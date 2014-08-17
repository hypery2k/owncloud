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
OC::$CLASSPATH['OC_Mail_NetworkingException'] = OC_App::getAppPath('roundcube') . '/lib/MailNetworkingException.class.php';
OC::$CLASSPATH['OC_Mail_LoginException'] = OC_App::getAppPath('roundcube') . '/lib/MailLoginException.class.php';
OC::$CLASSPATH['OC_Mail_RC_InstallNotFoundException'] = OC_App::getAppPath('roundcube') . '/lib/MailRoundCubeNotFoundException.class.php';
OC::$CLASSPATH['OC_Mail_Object'] = OC_App::getAppPath('roundcube') . '/lib/MailObject.class.php';
OC::$CLASSPATH['OC_RoundCube_App'] = OC_App::getAppPath('roundcube') . '/lib/RoundCubeApp.class.php';
OC::$CLASSPATH['OC_RoundCube_DB_Util'] = OC_App::getAppPath('roundcube') . '/lib/RoundCubeDBUtil.class.php';
OC::$CLASSPATH['OC_RoundCube_Login'] = OC_App::getAppPath('roundcube') . '/lib/RoundCubeLogin.class.php';
OC::$CLASSPATH['OC_RoundCube_AuthHelper'] = OC_App::getAppPath('roundcube') . '/lib/RoundCubeAuthHelper.class.php';

OCP\Util::connectHook('OC_User', 'post_login', 'OC_RoundCube_AuthHelper', 'login');
OCP\Util::connectHook('OC_User', 'logout', 'OC_RoundCube_AuthHelper', 'logout');
OCP\Util::connectHook('OC_User', 'post_setPassword', 'OC_RoundCube_AuthHelper', 'changePasswordListener');
// set refresh interval in JS namespace
OCP\Util::connectHook('\OCP\Config', 'js', 'OC_RoundCube_AuthHelper', 'jsLoadHook');

// probably no longer needed, now that we use routes ...
if (!OCP\Config::getAppValue('roundcube', 'rcNoCronRefresh', false)) {
	OCP\BackgroundJob::AddRegularTask('OC_RoundCube_AuthHelper', 'refresh');
}

// Add global JS routines; this one triggers an RC session refresh by
// periodically calling the refresh-script via js setInterval()
OCP\Util::addScript('roundcube', 'routes');

OCP\App::registerAdmin('roundcube', 'adminSettings');
OCP\App::registerPersonal('roundcube', 'userSettings');

OCP\App::addNavigationEntry(array(
'id' => 'roundcube_index',
'order' => 10,
'href' => OCP\Util::linkTo('roundcube', 'index.php'),
'icon' => OCP\Util::imagePath('roundcube', 'mail.svg'),
'name' => $l -> t('Webmail')
));
