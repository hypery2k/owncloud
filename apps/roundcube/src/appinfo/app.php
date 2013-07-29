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

$l = new OC_L10N('roundcube');
OC::$CLASSPATH['OC_RoundCube_App'] = 'roundcube/lib/mail.php';
OC::$CLASSPATH['OC_RoundCube_DB_Util'] = 'roundcube/lib/dbUtil.php';
OC::$CLASSPATH['RoundcubeLogin']   = 'roundcube/lib/RoundcubeLogin.class.php';
OC::$CLASSPATH['OC_RC_AutoSave'] = 'roundcube/lib/autosave.php';

$enable_auto_login = OCP\Config::getAppValue('roundcube', 'autoLogin', false);

if ($enable_auto_login) {
	OCP\Util::connectHook('OC_User', 'post_login','OC_RC_AutoSave','autoSave');
}

OCP\App::registerAdmin('roundcube', 'adminSettings');
OCP\App::registerPersonal('roundcube', 'userSettings');

OCP\App::addNavigationEntry(
	array(
		'id' => 'roundcube_index', 
		'order' => 10, 
		'href' => OCP\Util::linkTo('roundcube', 'index.php'), 
		'icon' => OCP\Util::imagePath('roundcube', 'mail.png'), 
		'name' => $l -> t('Webmail')
	)
);
?>
