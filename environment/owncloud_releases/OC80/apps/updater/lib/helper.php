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

class Helper {
	const APP_DIRNAME = 'apps';
	const THIRDPARTY_DIRNAME = '3rdparty';
	const CORE_DIRNAME = 'core';

	public static function checkVersion($newVersionArray, $newVersionString){
		$currentVersionArray = \OC_Util::getVersion();
		$currentVersion = \OC_Util::getVersionString();

		$difference = intval($newVersionArray[0]) - intval($currentVersionArray[0]);
		if ($difference>1 || $difference<0 || version_compare($currentVersion, $newVersionString) > 0) {
			$message = (string) App::$l10n->t(
				'Not possible to update %s to %s. Downgrading or skipping major releases is not supported.', 
				array(
					$currentVersion,
					implode('.', $newVersionArray)
				)
			); 
			App::log($message);
			throw new \Exception($message);
		}
	}

	/**
	 * Moves file/directory
	 * @param string $src  - source path
	 * @param string $dest - destination path
	 * @throws \Exception on error
	 */
	public static function move($src, $dest) {
		if (!rename($src, $dest)) {
			throw new \Exception("Unable to move $src to $dest");
		}
	}
	
	/**
	 * Check permissions recursive
	 * @param string $src  - path to check
	 * @param string $src  - path to check
	 */
	public static function checkr($src, $collection) {
		if (!is_writable($src)){
			$collection->addNotWritable($src);
		}
		if (!is_readable($src)){
			$collection->addNotReadable($src);
		}
		if(is_dir($src)) {
			$files = scandir($src);
			foreach ($files as $file) {
				if ($file != "." && $file != "..") {
					self::checkr("$src/$file", $collection);
				}
			}
		}
	}
	
	/**
	 * Copy recursive
	 * @param string $src  - source path
	 * @param string $dest - destination path
	 * @throws \Exception on error
	 */
	public static function copyr($src, $dest, $stopOnError = true) {
		if(is_dir($src)) {
			if(!is_dir($dest)) {
				try {
					self::mkdir($dest);
				} catch (\Exception $e){
					if ($stopOnError){
						throw $e;
					}
				}
			}
			$files = scandir($src);
			foreach ($files as $file) {
				if ($file != "." && $file != "..") {
					self::copyr("$src/$file", "$dest/$file", $stopOnError);
				}
			}
		}elseif(file_exists($src)) {
			if (!copy($src, $dest) && $stopOnError) {
				throw new \Exception("Unable copy $src to $dest");
			}
		}
	}

	/**
	 * Wrapper for mkdir
	 * @param string $path
	 * @param bool $isRecursive
	 * @throws \Exception on error
	 */
	public static function mkdir($path, $isRecursive = false) {
		if (!mkdir($path, 0755, $isRecursive)) {
			throw new \Exception("Unable to create $path");
		}
	}
	
	/**
	 * Get directory content as array
	 * @param string $path
	 * @return array 
	 * @throws \Exception on error
	 */
	public static function scandir($path) {
		$content = scandir($path);
		if (!is_array($content)) {
			throw new \Exception("Unable to list $path content");
		}
		return $content;
	}

	/**
	 * Silently remove the filesystem item
	 * Used for cleanup
	 * @param string $path
	 */
	public static function removeIfExists($path) {
		if (!file_exists($path)) {
			return;
		}

		if (is_dir($path)) {
			self::rmdirr($path);
		} else {
			@unlink($path);
		}
	}
	
	protected static function rmdirr($dir) {
		if(is_dir($dir)) {
			$files = scandir($dir);
			foreach($files as $file) {
				if ($file != "." && $file != "..") {
					self::rmdirr("$dir/$file");
				}
			}
			@rmdir($dir);
		}elseif(file_exists($dir)) {
			@unlink($dir);
		}
		if(file_exists($dir)) {
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * Get the list of directories to be replaced on update
	 * @return array
	 */
	public static function getDirectories() {
		$dirs = array();
		$dirs[self::THIRDPARTY_DIRNAME] = \OC::$THIRDPARTYROOT . '/' . self::THIRDPARTY_DIRNAME;
		
		if (isset(\OC::$APPSROOTS)) {
			foreach (\OC::$APPSROOTS as $i => $approot){
				$index = $i ? $i : '';
				$dirs[self::APP_DIRNAME . $index] = $approot['path'];
			}
		}
		
		$dirs[self::CORE_DIRNAME] = \OC::$SERVERROOT;
		return $dirs;
	}
	
	public static function getSources($version) {
		$base = Downloader::getPackageDir($version);
		return array (
			self::APP_DIRNAME => $base . '/' . self::APP_DIRNAME,
			self::THIRDPARTY_DIRNAME => $base . '/' . self::THIRDPARTY_DIRNAME,
			self::CORE_DIRNAME => $base . '/' . self::CORE_DIRNAME,	
		);
	}
	
	public static function addDirectoryToZip($zip, $dir) {
		$dirIterator = new \RecursiveDirectoryIterator($dir, \RecursiveDirectoryIterator::SKIP_DOTS);
		$iterator = new \RecursiveIteratorIterator($dirIterator, \RecursiveIteratorIterator::SELF_FIRST);
		foreach ($iterator as $key=>$file) {
			$relPath = str_replace($dir, '', $key);
			if ($file->isDir()){
				$zip->addEmptyDir($relPath);
			} else {
				$zip->addFile(realpath($key), $relPath);
			}
		}
		return $zip;
	}
}
