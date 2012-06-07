<?php
if ($_POST) {
	$myID = OC_Mail_App::existLoginData(OC_User::getUser());
	$mailuser = OC_Mail_App::cryptMyEntry($_POST['mailUsername']);
	$mailpass = OC_Mail_App::cryptMyEntry($_POST['mailPassword']);
	$stmt = OC_DB::prepare("UPDATE *PREFIX*mail SET mailUser = '$mailuser', mailPass = '$mailpass' WHERE id = $myID");
	$result = $stmt->execute();
}

// fill template
$tmpl = new OC_Template( 'mail', 'userSettings');
foreach($params as $param){
                $value = OC_Appconfig::getValue('mail', $param,'');
                $tmpl->assign($param, $value);
}
return $tmpl->fetchPage();
?>