<?php

OC::$CLASSPATH['OC_RoundCube_AuthHelper'] = OC_App::getAppPath('roundcube') . '/lib/RoundCubeAuthHelper.class.php';

$this->create('roundcube_refresh', '/refresh')->post()->action('OC_RoundCube_AuthHelper', 'refresh');

$this->create('roundcube_index', '/')->action(
    function($params){
        require __DIR__ . '/../index.php';
    }
);
