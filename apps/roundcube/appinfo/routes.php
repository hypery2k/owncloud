<?php

OC::$CLASSPATH['OC_RoundCube_AuthHelper'] = OC_App::getAppPath('roundcube') . '/lib/RoundCubeAuthHelper.class.php';

$this->create('roundcuberefresh', '/refresh')->post()->action('OC_RoundCube_AuthHelper', 'refresh');

?>
