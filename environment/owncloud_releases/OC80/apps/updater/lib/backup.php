<?php

/**
 * ownCloud - Updater plugin
 *
 * @author Victor Dubiniuk
 * @copyright 2012-2013 Victor Dubiniuk victor.dubiniuk@gmail.com
 *
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 */

namespace OCA\Updater;

class Backup {

	/**
	 * Path to the current Backup instance
	 * @var string
	 */
	protected static $path = '';
	
	/**
	 * Perform backup
	 * @return string
	 */
	public static function create($version) {
		$collection = new Collection();
		$installed = Helper::getDirectories();
		$sources = Helper::getSources($version);
		$thirdPartyUpdater = new \OCA\Updater\Location\Thirdparty(
						$installed[Helper::THIRDPARTY_DIRNAME],
						$sources[Helper::THIRDPARTY_DIRNAME]
		);
		$coreUpdater = new \OCA\Updater\Location\Core(
						$installed[Helper::CORE_DIRNAME],
						$sources[Helper::CORE_DIRNAME]
		);
		$appUpdater = new \OCA\Updater\Location\Apps(
						$installed[Helper::APP_DIRNAME],
						''
		);
		$thirdPartyFiles = $thirdPartyUpdater->collect(true);
		$coreFiles = $coreUpdater->collect(true);
		$appFiles = $appUpdater->collect(true);
		$locations = array(
			Helper::THIRDPARTY_DIRNAME => $thirdPartyFiles['old'], 
			Helper::CORE_DIRNAME => $coreFiles['old'],
			Helper::APP_DIRNAME => $appFiles['old']
		);
		foreach ($locations as $type => $dirs) {
			foreach ($dirs as $name => $path) {
				Helper::checkr($path, $collection);
			}
		}
		
		if (
				count($collection->getNotReadable())
				|| count($collection->getNotWritable())
		) {
			$e = new PermissionException();
			$e->setCollection($collection);
			throw $e;
		}
		
		try {
			Helper::mkdir(self::getPath(), true);
			foreach ($locations as $type => $dirs) {
				$backupFullPath = self::getPath() . '/' . $type . '/';
				
				Helper::mkdir($backupFullPath, true);
				foreach ($dirs as $name => $path) {
					Helper::copyr($path, $backupFullPath . $name);
				}
			}
		} catch (\Exception $e){
			App::log('Backup creation failed. Disk full?');
			self::cleanUp();
			throw new FsException($e->getMessage());
		}

		return self::getPath();
	}

	/**
	 * Generate unique backup path
	 * or return existing one
	 * @return string
	 */
	public static function getPath() {
		if (!self::$path) {
			$backupBase = App::getBackupBase();
			$currentVersion = \OCP\Config::getSystemValue('version', '0.0.0');
			$path = $backupBase . $currentVersion . '-';

			do {
				$salt = substr(md5(time()), 0, 8);
			} while (file_exists($path . $salt));

			self::$path = $path . $salt;
		}
		return self::$path;
	}

	public static function cleanUp(){
		if (self::$path) {
			Helper::removeIfExists(self::$path);
		}
		Helper::removeIfExists(App::getTempBase());
	}
}
