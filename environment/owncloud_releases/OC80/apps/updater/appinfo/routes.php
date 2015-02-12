<?php

/** @var $this \OC\Route\Router */

$this->create('updater_update', 'update.php')
	->actionInclude('updater/update.php');
$this->create('updater_admin', 'admin.php')
	->actionInclude('updater/admin.php');
$this->create('updater_ajax_backup', 'ajax/backup.php')
	->actionInclude('updater/ajax/backup.php');
$this->create('updater_ajax_download', 'ajax/download.php')
	->actionInclude('updater/ajax/download.php');
$this->create('updater_ajax_update', 'ajax/update.php')
	->actionInclude('updater/ajax/update.php');
$this->create('updater_ajax_backup_delete', 'ajax/backup/delete.php')
	->actionInclude('updater/ajax/backup/delete.php');
$this->create('updater_ajax_backup_download', 'ajax/backup/download.php')
	->actionInclude('updater/ajax/backup/download.php');
$this->create('updater_ajax_backup_list', 'ajax/backup/list.php')
	->actionInclude('updater/ajax/backup/list.php');

