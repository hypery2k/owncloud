<?php

$ocVersion = $_['ocVersion'];
$cfgClass = $ocVersion >= 7 ? 'section' : 'personalblock';

?>

<form id="rcMailAdminPrefs" action="#" method="post" class="<?php echo $cfgClass; ?>">
  <!-- Prevent CSRF attacks-->
  <input type="hidden" name="requesttoken" value="<?php echo $_['requesttoken'] ?>" id="requesttoken">
  <input type="hidden" name="appname" value="roundcube">
  
  <div id="roundcube" class="<?php echo $cfgClass; ?>">
    <legend><strong><?php echo $l -> t('RoundCube Settings'); ?></strong></legend>

    <ul>
      <li><a id="rcBasicSettings" href="#roundcube-1"><?php echo $l -> t('Basic settings'); ?></a></li>
      <li><a id="rcAdvancedSettings" href="#roundcube-2"><?php echo $l -> t('Advanced settings'); ?></a></li>
    </ul>
    
    <fieldset id="roundcube-1">
      <p>
        <label for="maildir">
            <?php echo $l -> t('Absolute path to roundcube installation, e.g. If you have http://example.com/roundcube enter /roundcube/ here. Note that subdomains or URLs do not work, just absolute paths to the same domain owncloud is running.'); ?>
        </label>
        <br/>
        <input type="text" id="maildir" name="maildir" style="width:400px;" value="<?php echo $_['maildir']; ?>"
               onchange="var lastChar = $('#maildir').val().substr($('#maildir').val().length - 1); if(lastChar !=='/') {$('#maildir').val($('#maildir').val()+'/');};}"  />
      </p>
    </fieldset>
    <fieldset id="roundcube-2">
      <table>
        <tr><td>
            <input type="checkbox" name="removeControlNav" id="removeControlNav"
                   <?php if ($_['removeControlNav']) echo ' checked'; ?>> 
            <label title="<?php echo $l -> t('Remove RoundCube control navigation menu items with currently logged in user information'); ?>" for="removeControlNav"><?php echo $l -> t('Remove information bar on top of page'); ?></label> 
          </td><td>
            <input type="checkbox" name="removeHeaderNav" id="removeHeaderNav"
                   <?php if ($_['removeHeaderNav']) echo ' checked'; ?>> 
            <label title="<?php echo $l -> t('Removes the buttons for different sections (mail, adressbook, settings) within the RoundCube mail application'); ?>" for="removeHeaderNav"><?php echo $l -> t('Remove RoundCube header navigation menu items'); ?></label> 
          </td><td>
        </tr><tr>
          <td> 
            <input type="checkbox" name="autoLogin" id="autoLogin"
                   <?php if ($_['autoLogin']) echo ' checked'; ?>>                   
            <label title="<?php echo $l -> t('Enable autologin for users, which reuse the login data from OC for RoundCube.'); ?>" for="autoLogin"><?php echo $l -> t('Enable autologin for users'); ?></label>
          </td><td>
            <input type="checkbox" name="enableDebug" id="enableDebug"
                   <?php if ($_['enableDebug']) echo ' checked'; ?>>
            <label title="<?php echo $l->t('Enable debug messages. RC tends to bloat the log-files.'); ?>" for="enableDebug"><?php echo $l->t('Enable debug logging'); ?></label>
          </td>
      </tr></table>
      <label for="rcHost">
        <?php echo $l -> t('Overwrite roundcube server hostname if not the same as owncloud, e.g. for (sub)domains which resides on the same server, e.g rc.domain.tld But keep in mind that due to iFrame security constraints it will be only working on the same server, see HTML/JS same-origin policies'); ?>
      </label>
      <input type="text" id="rcHost" name="rcHost" value="<?php echo $_['rcHost']; ?>">
      <br>
      <label for="rcPort">
        <?php echo $l -> t('Overwrite roundcube server port (If not specified, ports 80/443 are used for HTTP/S)'); ?>
      </label>
      <input type="text" id="rcPort" name="rcPort" value="<?php echo $_['rcPort']; ?>">
      <br>
      <label for="rcRefreshInterval" title="<?php echo $l->t('This should be set to somewhat (e.g. 60 seconds, YMMV) less than half the session life-time of your RoundCube install (refer to the Roundcube documentation, please).'); ?>">
        <?php echo $l -> t('Refresh interval for the Roundcube-session in seconds'); ?>
        <input type="text" id="rcRefreshInterval" name="rcRefreshInterval" value="<?php echo $_['rcRefreshInterval']; ?>">
      </label>
      <input type="checkbox" name="rcNoCronRefresh" id="rcNoCronRefresh"
                   <?php if ($_['rcNoCronRefresh']) echo ' checked'; ?>>
            <label title="<?php echo $l->t('Checking this box will disable the cron-job which should periodically refresh the Roundcube session. If you do not have a real cron-daemon running (see Cron-section on this page) then the cron-job is probably quite useless and unreliable and so it might be safe to disable it (YMMV).'); ?>" for="rcNoCronRefresh"><?php echo $l->t('Disable Cron session-refresh'); ?></label>
      <br>
    </fieldset>
    <input id="rcAdminSubmit" type="submit" value="Save" />
    <div id="adminmail_update_message" class="statusmessage"><?php echo $l->t('Saving...'); ?></div>
    <div id="adminmail_error_message" class="errormessage"></div>
    <div id="adminmail_success_message" class="successmessage"></div>
  </div>
</form>
