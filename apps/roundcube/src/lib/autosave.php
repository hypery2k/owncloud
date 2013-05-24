<?php
class OC_RC_AutoSave {
	static public function autoSave($params) {
		$myID = OC_RoundCube_App::existLoginData(OCP\User::getUser());
		$mail_user = OC_RoundCube_App::cryptMyEntry($params['uid']);
		$mail_password = OC_RoundCube_App::cryptMyEntry($params['password']);
		$stmt = OCP\DB::prepare("UPDATE *PREFIX*roundcube SET mail_user = ?, mail_password = ? WHERE id = ?");
		$result = $stmt -> execute(array($mail_user, $mail_password, $myID));
	}

}
?>