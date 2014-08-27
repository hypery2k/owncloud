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

      // Ajax foobar
      $.post(OC.filePath('roundcube', 'ajax', 'adminSettings.php'), post, function(data) {
	if (data.status == 'success') {
	  $('#adminmail_update_message').html(data.data.message);
	  $('#adminmail_update_message').show();
	} else {
	  $('#adminmail_update_message').html(data.data.message);
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