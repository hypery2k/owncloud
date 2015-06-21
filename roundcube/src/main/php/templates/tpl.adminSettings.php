<form id="rcMailAdminPrefs" action="#" method="post">
	<!-- Prevent CSRF attacks-->
	<input type="hidden" name="requesttoken" value="<?php echo $_['requesttoken'] ?>" id="requesttoken">
	<input type="hidden" name="appname" value="roundcube">
	<div id="roundcube" class="section">
		<h2><?php echo $l -> t('RoundCube Settings'); ?></h2>
		<h3><?php echo $l -> t('Basic settings'); ?></h3>
		<br>
		<label for="maildir"> <?php echo $l -> t('Absolute path to roundcube installation, e.g. If you have http://example.com/roundcube enter /roundcube/ here. Note that subdomains or URLs do not work, just absolute paths to the same domain owncloud is running.'); ?>
		</label>
		<br>
		<input type="text" id="maildir" name="maildir"
			style="width: 400px;" value="<?php echo $_['maildir']; ?>"
			onchange="var lastChar = $('#maildir').val().substr($('#maildir').val().length - 1); if(lastChar !=='/') {$('#maildir').val($('#maildir').val()+'/');};}" />		
		<br> 
		<label for="rcRefreshInterval"
			title="<?php echo $l->t('This should be set to somewhat (e.g. 60 seconds, YMMV) less than half the session life-time of your RoundCube install (refer to the Roundcube documentation, please).'); ?>">
			<?php echo $l -> t('Refresh interval for the Roundcube-session in seconds'); ?>
			<input type="text" id="rcRefreshInterval" name="rcRefreshInterval"
			value="<?php echo $_['rcRefreshInterval']; ?>">
		</label> 
		<br>
		<br>
		<h3><?php echo $l -> t('Advanced settings'); ?></h3>
		<br>
		<input type="checkbox" name="removeControlNav" id="removeControlNav"
		<?php if ($_['removeControlNav']) echo ' checked'; ?>>
		<label
			title="<?php echo $l -> t('Remove RoundCube control navigation menu items with currently logged in user information'); ?>"
			for="removeControlNav"><?php echo $l -> t('Remove information bar on top of page'); ?>
		</label> 
		<br>
		<input type="checkbox" name="noSSLverify"
			id="noSSLverify"
			<?php if ($_['noSSLverify']) echo ' checked'; ?>> 
		<label
			title="<?php echo $l -> t('Disable SSL verification, e.g. for self-signed certificates'); ?>"
			for="noSSLverify"><?php echo $l -> t('Disable SSL verification, e.g. for self-signed certificates'); ?>
		</label> 		
		<br>
		<input type="checkbox" name="autoLogin" id="autoLogin"
		<?php if ($_['autoLogin']) echo ' checked'; ?>> <label
			title="<?php echo $l -> t('Enable autologin for users, which reuse the login data from OC for RoundCube.'); ?>"
			for="autoLogin"><?php echo $l -> t('Enable autologin for users'); ?>
		</label> 
        <br>
        <input type="checkbox" name="removeHeaderNav" id="removeHeaderNav"
        <?php if ($_['removeHeaderNav']) echo ' checked'; ?>>
        <label
            title="<?php echo $l -> t('Removes the buttons for different sections (mail, adressbook, settings) within the RoundCube mail application'); ?>"
            for="removeHeaderNav"><?php echo $l -> t('Remove RoundCube header navigation menu items'); ?>
        </label>
		<br>
		<input type="checkbox" name="enableDebug" id="enableDebug"
		<?php if ($_['enableDebug']) echo ' checked'; ?>> 
		<label
			title="<?php echo $l->t('Enable debug messages. RC tends to bloat the log-files.'); ?>"
			for="enableDebug"><?php echo $l->t('Enable debug logging'); ?>
		</label> 
		<br>
		<br>
		<label for="rcHost"> <?php echo $l -> t('Overwrite roundcube server hostname if not the same as owncloud, e.g. for (sub)domains which resides on the same server, e.g rc.domain.tld But keep in mind that due to iFrame security constraints it will be only working on the same server, see HTML/JS same-origin policies'); ?>
		</label> 
		<input type="text" id="rcHost" name="rcHost"
			value="<?php echo $_['rcHost']; ?>"> 
		<br> 
		<label for="rcPort"> <?php echo $l -> t('Overwrite roundcube server port (If not specified, ports 80/443 are used for HTTP/S)'); ?>
		</label> 
		<input type="text" id="rcPort" name="rcPort"
			value="<?php echo $_['rcPort']; ?>">
		<br>
		<br>
		<input id="rcAdminSubmit" type="submit" value="Save" />
		<div id="adminmail_update_message" class="statusmessage">
			<?php echo $l->t('Saving...'); ?>
		</div>
		<div id="adminmail_error_message" class="errormessage"></div>
		<div id="adminmail_success_message" class="successmessage"></div>
	</div>
</form>
