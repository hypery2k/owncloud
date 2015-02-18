<?php

$this->create('storagecharts2_index', '/')->action(
		function($params){
			require OC_App::getAppPath('storagecharts2').'/index.php';
		}
);

$this->create('storagecharts2_ajax_userSettings', 'ajax/userSettings.php')->actionInclude(OC_App::getAppPath('storagecharts2').'/ajax/userSettings.php');
$this->create('storagecharts2_ajax_data', 'ajax/data.php')->actionInclude(OC_App::getAppPath('storagecharts2').'/ajax/data.php');
