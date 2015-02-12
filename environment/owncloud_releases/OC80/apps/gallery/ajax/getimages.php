<?php
/**
 * Copyright (c) 2012 Robin Appelman <icewind@owncloud.com>
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

OCP\JSON::checkAppEnabled('gallery');
$path = null;

if (isset($_GET['token'])) {
	$token = $_GET['token'];
	$linkItem = \OCP\Share::getShareByToken($token);
	if (is_array($linkItem) && isset($linkItem['uid_owner'])) {
		// seems to be a valid share
		$type = $linkItem['item_type'];
		$fileSource = $linkItem['file_source'];
		$shareOwner = $linkItem['uid_owner'];
		
		$rootLinkItem = \OCP\Share::resolveReShare($linkItem);
		$fileOwner = $rootLinkItem['uid_owner'];

		// Setup FS with owner
		OCP\JSON::checkUserExists($fileOwner);
		OC_Util::tearDownFS();
		OC_Util::setupFS($fileOwner);

		// The token defines the target directory (security reasons)
		$path = \OC\Files\Filesystem::getPath($linkItem['file_source']);

		$view = new \OC\Files\View(\OC\Files\Filesystem::getView()->getAbsolutePath($path));
		$images = $view->searchByMime('image');

		$result = array();
		foreach ($images as $image) {
			$result[] = trim($image['path'], '/');
		}

		OCP\JSON::setContentTypeHeader();
		echo json_encode($result);

		exit;
	}
}

OCP\JSON::checkLoggedIn();
OCP\JSON::checkAppEnabled('gallery');

$images = \OCP\Files::searchByMime('image');
$user = \OCP\User::getUser();
$users = array();
$result = array();

if($path == null){
	
	$path='/';
}

foreach ($images as $image) {
	if (strpos($path, DIRECTORY_SEPARATOR . ".")) {
		continue;
	}
	$result[] = trim($image['path'], '/');
}

function startsWith($haystack, $needle) {
	return !strncmp($haystack, $needle, strlen($needle));
}

OCP\JSON::setContentTypeHeader();
echo json_encode($result);
