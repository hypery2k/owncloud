<?php
/**
 * Copyright (c) 2014 Robin Appelman <icewind@owncloud.com>
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

/** @var $this OC\Route\Router */

$this->create('gallery_index', '/')
	->actionInclude('gallery/index.php');
$this->create('gallery_ajax_gallery', 'ajax/gallery')
	->actionInclude('gallery/ajax/gallery.php');
$this->create('gallery_ajax_images', 'ajax/images')
	->actionInclude('gallery/ajax/getimages.php');
$this->create('gallery_ajax_image', 'ajax/image')
	->actionInclude('gallery/ajax/image.php');
$this->create('gallery_ajax_thumbnail', 'ajax/thumbnail')
	->actionInclude('gallery/ajax/thumbnail.php');
$this->create('gallery_ajax_batch', 'ajax/thumbnail/batch')
	->actionInclude('gallery/ajax/batch.php');

$this->create('gallery_public', '/public/{token}')
	->actionInclude('gallery/public.php');
