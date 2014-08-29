// declare namespace
var Roundcube = Roundcube || {};

/**
 * init admin settings view
 */
Roundcube.adminSettingsUI = function() {

  if ($('#roundcube').length > 0) {
    // enable tabs on settings page
    $('#roundcube').tabs();

    $('#rcAdminSubmit').click(function(event) {
      event.preventDefault();

      var self = $(this);
      var post = $('#rcMailAdminPrefs').serialize();
      $('#adminmail_update_message').html('<span class="adminmail_msg_status">Saving...</span>');
      $('#adminmail_update_message').show();

      // Ajax foobar
      $.post(OC.filePath('roundcube', 'ajax', 'adminSettings.php'), post, function(data) {
	if (data.status == 'success') {
	  $('#adminmail_update_message').html('<span class="adminmail_msg_success">'+data.data.message+'</span>');
	  $('#adminmail_update_message').show();
	  window.setTimeout(function() {
              $('#adminmail_update_message').hide();
	  }, 10000);
	} else {
	  $('#adminmail_update_message').html('<span class="adminmail_msg_error">'+data.data.message+'</span>');
	  $('#adminmail_update_message').show();
	}
      }, 'json');
      return false;
    });
  }
}

$(document).ready(function() {
  if ($('#roundcube')) {
    Roundcube.adminSettingsUI();
  }
});
