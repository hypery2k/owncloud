<?php

/**
 * ownCloud - Updater plugin
 *
 * @author Victor Dubiniuk
 * @copyright 2013 Victor Dubiniuk victor.dubiniuk@gmail.com
 *
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 */

namespace OCA\Updater\Location;

use OCA\Updater\Location as Location;
use OCA\Updater\Helper;

class Apps extends Location {

	protected $type = 'apps';
	protected $appsToUpdate = array();
	
	public function update($tmpDir = '') {
		Helper::mkdir($tmpDir, true);
		$this->collect();
		try {
			foreach ($this->appsToUpdate as $appId) {
				if (!@file_exists($this->newBase . '/' . $appId)){
					continue;
				}
				$path = \OC_App::getAppPath($appId);
				if ($path) {
					Helper::move($path, $tmpDir . '/' . $appId);
					
					// ! reverted intentionally
					$this->done [] = array(
						'dst' => $path,
						'src' => $tmpDir . '/' . $appId
					);
					
					Helper::move($this->newBase . '/' . $appId, $path);
				} else { 
					// The app is new and doesn't exist in the current instance
					$pathData = first(\OC::$APPSROOTS);
					Helper::move($this->newBase . '/' . $appId, $pathData['path'] . '/' . $appId);
				}
			}
			$this->finalize();
		} catch (\Exception $e) {
			$this->rollback(true);
			throw $e;
		}
	}

	public function collect($dryRun = false) {
		$result = array();
		$dir = $dryRun ? $this->oldBase : $this->newBase;
		$dh = opendir($dir);
		if (is_resource($dh)) {
			while (($file = readdir($dh)) !== false) {
				if ($file[0] != '.' && is_file($dir . '/' . $file . '/appinfo/app.php')) {
					$this->appsToUpdate[$file] =  $file;
					if ($dryRun){
						$result['old'][$file] = realpath($dir . '/' . $file);
					}
				}
			}
		}
		return $result;
	}
}
