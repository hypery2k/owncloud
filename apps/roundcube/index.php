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

// Check if we are a user
if (!OCP\User::isLoggedIn()) {
  header("Location: " . OCP\Util::linkTo('', 'index.php'));
  exit();
}

// Load our style
OCP\Util::addStyle('roundcube', 'base');
// add neede JS
//OCP\Util::addScript('', 'jquery-1.7.2.min');
OCP\Util::addScript('core', 'jquery-showpassword');
OCP\Util::addScript('roundcube', 'jquery.plugins');
OCP\Util::addScript('roundcube', 'mail');
OCP\Util::addScript('roundcube', 'modernizr');

// add new navigation entry
OCP\App::setActiveNavigationEntry("roundcube_index");

$tmpl = new OCP\Template("roundcube", "mail", "user");
$tmpl -> printpage();

?>
