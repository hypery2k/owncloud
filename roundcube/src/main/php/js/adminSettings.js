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
      $('#adminmail_update_message').show();
      $('#adminmail_success_message').hide();
      $('#adminmail_error_message').hide();
      // Ajax foobar
      $.post(OC.filePath('roundcube', 'ajax', 'adminSettings.php'), post, function(data) {
        $('#adminmail_update_message').hide();
        if (data.status == 'success') {
          $('#adminmail_success_message').html(data.data.message);
          $('#adminmail_success_message').show();
          window.setTimeout(function() {
              $('#adminmail_success_message').hide();
          }, 10000);
        } else {
          $('#adminmail_error_message').html(data.data.message);
          $('#adminmail_error_message').show();
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
