<?php

/**
 * ownCloud - Activity App
 *
 * @author Joas Schilling
 * @copyright 2014 Joas Schilling nickvergessen@owncloud.com
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

namespace OCA\Activity;

/**
 * Class Api
 *
 * @package OCA\Activity
 */
class Api
{
	const DEFAULT_LIMIT = 30;

	static public function get($param) {
		$app = new AppInfo\Application();
		$data = $app->getContainer()->query('ActivityData');

		$start = isset($_GET['start']) ? $_GET['start'] : 0;
		$count = isset($_GET['count']) ? $_GET['count'] : self::DEFAULT_LIMIT;

		$activities = $data->read(
			$app->getContainer()->query('GroupHelper'),
			$app->getContainer()->query('UserSettings'),
			$start, $count, 'all'
		);

		$entries = array();
		foreach($activities as $entry) {
			$entries[] = array(
				'id' => $entry['activity_id'],
				'subject' => (string) $entry['subjectformatted']['full'],
				'message' => (string) $entry['messageformatted']['full'],
				'file' => $entry['file'],
				'link' => $entry['link'],
				'date' => date('c', $entry['timestamp']),
			);
		}

		return new \OC_OCS_Result($entries);
	}
}
