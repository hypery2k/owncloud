<?php
/**
 * Copyright (c) 2014 Morris Jobke <>
 * This file is licensed under the Affero General Public License version 3 or
 * later.
 * See the COPYING-README file.
 */

/** @var $this OC\Route\Router */

$this->create('firstrunwizard_enable', 'ajax/enable.php')
	->actionInclude('firstrunwizard/ajax/enable.php');
$this->create('firstrunwizard_disable', 'ajax/disable.php')
	->actionInclude('firstrunwizard/ajax/disable.php');
$this->create('firstrunwizard_wizard', 'wizard.php')
	->actionInclude('firstrunwizard/wizard.php');

