<?php

/**
 * ownCloud - Reveal App
 *
 * @author Raghu Nayyar and Frank Karlitschek
 * @copyright 2012 Raghu Nayyar me@iraghu.com Frank Karlitschek karlitschek@kde.org
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

require_once 'lib/reveal.php';

OCP\User::checkLoggedIn();
OCP\JSON::checkAppEnabled('reveal');
OCP\App::setActiveNavigationEntry( 'reveal_index' );

$tmpl = new OCP\Template('reveal', 'documentation', 'user');
$tmpl->printPage();