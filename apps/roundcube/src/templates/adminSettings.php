<form id="mail" action="#" method="post">
	<fieldset class="personalblock">
		<legend><strong>RoundCube Mail</strong></legend>
		<p>
			<label for="mail"><?php echo $l->t('Roundcubedir');?>
				<input type="text" id="maildir" name="maildir" value="<?php echo $_['maildir']; ?>"><?php echo $l->t('e.g. /mail/, relative to the owncloud installation'); ?>
			</label>
		</p>
		<p>
			<label for="mail"><?php echo $l->t('Encryptstring1');?>
				<input type="text" id="encryptstring1" name="encryptstring1" value="<?php echo $_['encryptstring1']; ?>"><?php echo $l->t('optional encryptionstring (your mailuser and password will be encrypted)'); ?>
			</label>
		</p>
		<p>
			<label for="mail"><?php echo $l->t('Encryptstring2');?>
				<input type="text" id="encryptstring2" name="encryptstring2" value="<?php echo $_['encryptstring2']; ?>"><?php echo $l->t('What\'s this for?'); ?>
			</label>
		</p>
		<input type="submit" value="Save" />
	</fieldset>
</form>
