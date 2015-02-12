<?php
/**
 * Copyright (c) 2012 Robin Appelman <icewind@owncloud.com>
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

OCP\JSON::checkAppEnabled('gallery');

$square = isset($_GET['square']) ? (bool)$_GET['square'] : false;
$scale = isset($_GET['scale']) ? $_GET['scale'] : 1;
$images = explode(';', $_GET['image']);

if (!empty($_GET['token'])) {
	$linkItem = \OCP\Share::getShareByToken($_GET['token']);
	if (!(is_array($linkItem) && isset($linkItem['uid_owner']))) {
		exit;
	}
	// seems to be a valid share
	$rootLinkItem = \OCP\Share::resolveReShare($linkItem);
	$user = $rootLinkItem['uid_owner'];

	// Setup filesystem
	OCP\JSON::checkUserExists($user);
	OC_Util::tearDownFS();
	OC_Util::setupFS($user);

	$root = \OC\Files\Filesystem::getPath($linkItem['file_source']) . '/';
	$images = array_map(function ($image) use ($root) {
		return $root . $image;
	}, $images);
} else {
	$root = '';
	OCP\JSON::checkLoggedIn();
	$user = OCP\User::getUser();
}

session_write_close();
$eventSource = new OC_EventSource();

foreach ($images as $image) {
	$height = 200 * $scale;
	if ($square) {
		$width = 200 * $scale;
	} else {
		$width = 400 * $scale;
	}

	$userView = new \OC\Files\View('/' . $user);

	$preview = new \OC\Preview($user, 'files', '/' . $image, $width, $height);
	$preview->setKeepAspect(!$square);

	$fileInfo = $userView->getFileInfo('/files/' . $image);

	// if the thumbnails is already cached, get it directly from the filesystem to avoid decoding and re-encoding the image
	$imageName = substr($image, strlen($root));
	if ($path = $preview->isCached($fileInfo->getId())) {
		$eventSource->send('preview', array(
			'image' => $imageName,
			'preview' => base64_encode($userView->file_get_contents('/' . $path))
		));
	} else {
		$eventSource->send('preview', array(
			'image' => $imageName,
			'preview' => (string)$preview->getPreview()
		));
	}
}
$eventSource->close();
