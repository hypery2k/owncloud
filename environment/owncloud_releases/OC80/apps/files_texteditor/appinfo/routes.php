<?php
/**
 * Copyright (c) 2014 Robin Appelman <icewind@owncloud.com>
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

/** @var $this OC\Route\Router */

$this->create('files_texteditor_load', '/ajax/loadfile.php')
	->actionInclude('files_texteditor/ajax/loadfile.php');
$this->create('files_texteditor_save', 'ajax/savefile.php')
	->actionInclude('files_texteditor/ajax/savefile.php');
