<?php
/**
 * ownCloud - Activity App
 *
 * @author Thomas Müller
 * @copyright 2013 Thomas Müller deepdiver@owncloud.com
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

use OCP\Activity\IConsumer;
use OCP\Activity\IManager;
use OCP\AppFramework\IAppContainer;

class Consumer implements IConsumer {
	/**
	 * Registers the consumer to the Activity Manager
	 *
	 * @param IManager $am
	 * @param IAppContainer $container
	 */
	public static function register(IManager $am, IAppContainer $container) {
		$am->registerConsumer(function() use ($am, $container) {
			return $container->query('Consumer');
		});
	}

	/** @var UserSettings */
	protected $userSettings;

	/**
	 * Constructor
	 *
	 * @param UserSettings $userSettings
	 */
	public function __construct(UserSettings $userSettings) {
		$this->userSettings = $userSettings;
	}

	/**
	 * Send an event into the activity stream of a user
	 *
	 * @param string $app The app where this event is associated with
	 * @param string $subject A short description of the event
	 * @param array  $subjectParams Array with parameters that are filled in the subject
	 * @param string $message A longer description of the event
	 * @param array  $messageParams Array with parameters that are filled in the message
	 * @param string $file The file including path where this event is associated with. (optional)
	 * @param string $link A link where this event is associated with (optional)
	 * @param string $affectedUser If empty the current user will be used
	 * @param string $type Type of the notification
	 * @param int    $priority Priority of the notification
	 * @return null
	 */
	public function receive($app, $subject, $subjectParams, $message, $messageParams, $file, $link, $affectedUser, $type, $priority) {
		$selfAction = substr($subject, -5) === '_self';
		$streamSetting = $this->userSettings->getUserSetting($affectedUser, 'stream', $type);
		$emailSetting = $this->userSettings->getUserSetting($affectedUser, 'email', $type);
		$emailSetting = ($emailSetting) ? $this->userSettings->getUserSetting($affectedUser, 'setting', 'batchtime') : false;

		// Add activity to stream
		if ($streamSetting && (!$selfAction || $this->userSettings->getUserSetting($affectedUser, 'setting', 'self'))) {
			Data::send($app, $subject, $subjectParams, $message, $messageParams, $file, $link, $affectedUser, $type, $priority);
		}

		// Add activity to mail queue
		if ($emailSetting && (!$selfAction || $this->userSettings->getUserSetting($affectedUser, 'setting', 'selfemail'))) {
			$latestSend = time() + $emailSetting;
			Data::storeMail($app, $subject, $subjectParams, $affectedUser, $type, $latestSend);
		}
	}
}
