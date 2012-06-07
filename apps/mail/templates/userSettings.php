<?php
$mailuserdata = OC_Mail_App::checkLoginData(OC_User::getUser());
$mailUsername = OC_Mail_App::decryptMyEntry($mailuserdata['mailUser']);
$mailPassword = OC_Mail_App::decryptMyEntry($mailuserdata['mailPass']);
?>

<form id="usermail" action="#" method="post">
	<fieldset class="personalblock">
		<legend><strong>Mailaccount</strong></legend>
        <p>
        	<label for="usermail"><?php echo $l->t('Username');?>
        		<input type="text" id="mailUsername" name="mailUsername" value="<?=$mailUsername;?>">
        	</label>
        	<label for="usermail"><?php echo $l->t('Password');?>
        		<input type="password" id="mailPassword" name="mailPassword" value="<?=$mailPassword;?>">
        	</label></p>
        <input type="submit" value="Save" />
	</fieldset>
</form>