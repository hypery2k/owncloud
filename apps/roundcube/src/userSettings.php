<?php
if ($_POST) {
	$myID = OC_RoundCube_App::existLoginData(OC_User::getUser());
	$mailuser = OC_RoundCube_App::cryptMyEntry($_POST['mailUsername']);
	$mailpass = OC_RoundCube_App::cryptMyEntry($_POST['mailPassword']);
	$stmt = OC_DB::prepare("UPDATE *PREFIX*roundcube SET \"mailUser\" = '$mailuser', \"mailPass\" = '$mailpass' WHERE id = $myID");
	$result = $stmt->execute();
}

// fill template
$tmpl = new OC_Template( 'roundcube', 'userSettings');
foreach($params as $param){
                $value = OC_Appconfig::getValue('roundcube', $param,'');
                $tmpl->assign($param, $value);
}
return $tmpl->fetchPage();
?>