<?php

/**
 * ownCloud - Activity App
 *
 * @author Frank Karlitschek
 * @copyright 2013 Frank Karlitschek frank@owncloud.org
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
 * You should have received a copy of the GNU Affero General Public
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

namespace OCA\Activity\AppInfo;

/** @var $this \OC\Route\Router */
$this->create('activity.rss', 'rss.php')
	->actionInclude('activity/rss.php');

// Register an OCS API call
\OC_API::register(
	'get',
	'/cloud/activity',
	array('OCA\Activity\Api', 'get'),
	'activity'
);

$application = new Application();
$application->registerRoutes($this, ['routes' => [
	['name' => 'Settings#personal', 'url' => '/settings', 'verb' => 'POST'],
	['name' => 'Settings#feed', 'url' => '/settings/feed', 'verb' => 'POST'],
	['name' => 'Activities#showList', 'url' => '/', 'verb' => 'GET'],
	['name' => 'Activities#fetch', 'url' => '/activities/fetch', 'verb' => 'GET'],
]]);
