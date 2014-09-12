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

// Check if we are a user
OCP\User::checkLoggedIn();
OCP\App::checkAppEnabled('roundcube');

OCP\Util::addStyle('roundcube', 'userSettings');
OCP\Util::addScript('roundcube', 'userSettings');

// fill template
$params = array();
$tmpl = new OCP\Template('roundcube', 'tpl.userSettings');
foreach ($params as $param) {
	$value = OCP\Config::getAppValue('roundcube', $param, '');
	$tmpl -> assign($param, $value);
}

// workaround to detect OC version
$ocVersion = @reset(OCP\Util::getVersion());
$tmpl->assign('ocVersion', $ocVersion);

return $tmpl -> fetchPage();
