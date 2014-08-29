// declare namespace
var Roundcube = Roundcube || {};

/**
 * init admin settings view
 */
Roundcube.userSettingsUI = function() {
  // Pseudo subit. In General, we do not like submitting forms in
  // favor of the Ajax technology. Its just more handy and less
  // error-prone.

  $("#rc_usermail_update").click(function(event) {
    event.preventDefault();

    var self = $(this);
    var password = $('#rc_mail_settings #rc_mail_password').val();
    var user = $('#rc_mail_settings #rc_mail_username').val();

    $('#rc_mail_update_message').hide();
    $('#rc_mail_error_message').hide();
    $('#rc_mail_error_empty_message').hide();
    if (password != '' && user != '') {
      // Serialize the data
      var post = $("#rc_mail_settings").serialize();
      // Ajax foo
      $.post(OC.filePath('roundcube', 'ajax', 'userSettings.php'), post, function(data) {
	if (data.status == 'success') {
	  $('#rc_mail_update_message').html(data.data.message);
	  $('#rc_mail_update_message').show();
	} else {
	  console.error("Couldn't update roundcube settings.");
	  $('#rc_mail_error_message').show();
	}
      }, 'json');
    } else {
      console.error("Couldn't update roundcube settings due to empty");
      $('#rc_mail_error_empty_message').show();
    }
  });
}

$(document).ready(function() {
  Roundcube.userSettingsUI();
});