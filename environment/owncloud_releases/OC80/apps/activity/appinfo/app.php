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

$app = new Application();
$c = $app->getContainer();

// add an navigation entry
$navigationEntry = array(
	'id' => $c->getAppName(),
	'order' => 1,
	'name' => $c->query('ActivityL10N')->t('Activity'),
	'href' => $c->query('URLGenerator')->linkToRoute('activity.Activities.showList'),
	'icon' => $c->query('URLGenerator')->imagePath('activity', 'activity.svg'),
);
$c->getServer()->getNavigationManager()->add($navigationEntry);

// register the hooks for filesystem operations. All other events from other apps has to be send via the public api
\OCA\Activity\HooksStatic::register();
\OCA\Activity\Consumer::register($c->getServer()->getActivityManager(), $c);

// Personal settings for notifications and emails
\OCP\App::registerPersonal($c->getAppName(), 'personal');

// Cron job for sending Emails
\OCP\Backgroundjob::registerJob('OCA\Activity\BackgroundJob\EmailNotification');
\OCP\Backgroundjob::registerJob('OCA\Activity\BackgroundJob\ExpireActivities');
