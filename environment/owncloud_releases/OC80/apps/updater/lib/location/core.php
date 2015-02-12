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
use OCA\Updater\App;
use OCA\Updater\Helper;

class Core extends Location {

	protected $type = 'core';
	
	protected function getWhitelist(){
		$strList = file_get_contents(dirname(__DIR__) . '/files.json');
		$fullList = json_decode($strList, true);
		$list = $fullList['generic'];
		return $list;
	}

	protected function filterOld($pathArray) {
		$whitelist = $this->getWhitelist();

		// Skip 3rdparty | apps | backup | datadir | config | themes
		foreach ($pathArray as $key => $path) {
			if (!in_array($path, $whitelist)) {
				unset($pathArray[$key]);
			}
		}
		return $pathArray;
	}

	protected function filterNew($pathArray) {
		// Skip config | themes
		foreach ($pathArray as $key => $path) {
			if ($path === 'config' || $path === 'themes') {
				unset($pathArray[$key]);
			}
		}
		return $pathArray;
	}

	protected function finalize() {
		// overwrite themes content with new files only
		$themes = $this->toAbsolute(
				$this->newBase . '/themes', Helper::scandir($this->newBase . '/themes')
		);

		foreach ($themes as $name => $location) {
			Helper::removeIfExists($this->oldBase . '/themes/' . $name);
			Helper::move($location, $this->oldBase . '/themes/' . $name);
		}

		parent::finalize();
	}
}
