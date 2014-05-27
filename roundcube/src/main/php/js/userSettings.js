$(document).ready(function() {
	try {
		// 'show password' checkbox
		var element = $('#mail_password');
		var tmp = element.val();
		var placeholder = element.attr('placeholder');
		element.showPassword();
		element.val(tmp);

		// Pseudo subit. In General, we do not like submitting forms in
		// favor of the Ajax technology. Its just more handy and less
		// error-prone.

		$("#usermail_update").click(function(event) {
			event.preventDefault();

			var self = $(this);
			var password = $('#usermail #mail_password').val();
			var user = $('#usermail #mail_username').val();

			$('div.statusmessage').hide();
			$('span.statusmessage').hide();
			if (password != '' && user != '') {
				// Serialize the data
				var post = $("#usermail").serialize();
				// Ajax foo
				$.post(OC.filePath('roundcube', 'ajax', 'userSettings.php'), post, function(data) {
					if (data.status == 'success') {
						$('#usermail_update_message').html(data.data.message);
						$('#usermail_update_message').show();
					} else {
						$('#usermail_update_message').html(data.data.message);
						$('#usermail_update_message').show();
					}
				}, 'json');
				return false;
			} else {
				$('#userkey #error').show();
				return false;
			}

		});
	} catch(e) {
	}

});

// Local Variables: ***
// js-indent-level: 2 ***
// End: ***
