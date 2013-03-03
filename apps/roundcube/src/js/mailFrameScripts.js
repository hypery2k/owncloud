$(document).ready(function() {
	$(window).resize(function() {
		if (rc.logdebug) {
			console.log("Starting roundcube container resize ...");
		}
		fillWindow($('#roundcube_container'));
	});
	// check if the control menu from roundcube was disabled
	if ($('#disable_control_nav').val() === '1') {
		$('#roundcube_container').css('top', '3.5em');
	}
	$(window).resize();
	$('#roundcube_container').scroll(updateOnBottom).empty().width($('#content').width());
});

$('#roundcubeFrame').load(function() {
	var mainscreen = $('#roundcubeFrame').contents().find('#mainscreen');
	// remove header line, includes about line and
	var top_line = $('#roundcubeFrame').contents().find('#topline');
	// correct top padding
	var top_margin = 10;
	try {
		var top_nav = $('#roundcubeFrame').contents().find('#topnav');
		// check if the above element exits (only in new larry theme, if null use rc 0.7 default theme
		// TODO refactor and move theme check
		if (top_nav.height() != null) {
			top_margin = 10;
			//In larry theme with accounts plugin, we have to move the account selection
			var acc_select = top_line.find('.username');
			if (acc_select) {
				mainscreen.find('div#messagetoolbar').attr('id', 'ocrcMessagetoolbar');
				//Quick n dirty for space
				acc_select.appendTo(mainscreen.find('div#searchfilter')).css({
					position : 'absolute',
					top : '0px',
					left : '-170px'
				});
				var messagetoolbar = mainscreen.find('div#ocrcMessagetoolbar');
				messagetoolbar.css('left', '0');
				messagetoolbar.css('right', '390px');
        //Extend messagetoolbar, if fullwidth is specified
        mainscreen.find('.fullwidth').css('right', '0px');
				var toolbarselect = messagetoolbar.find('.toolbarselect');
				toolbarselect.css('position', 'absolute');
				toolbarselect.css('bottom', '6px');
				toolbarselect.css('right', '3px');
			}
		} else {
			top_margin = parseInt(mainscreen.css('top'), 10) - top_line.height();
		}
	} catch (e) {
	}
	top_line.remove();

	// fix topbar, issue https://github.com/hypery2k/owncloud/issues/54
	$('#roundcubeFrame').contents().find('.toolbar').css('z-index', '80');
	$('#roundcubeFrame').contents().find('.toolbar').css('position', 'absolute');

	// remove logout button
	$('#roundcubeFrame').contents().find('.button-logout').remove();

	// check if the header menu from roundcube was disabled
	if ($('#disable_header_nav').val() === 'on') {

		var top_nav = $('#roundcubeFrame').contents().find('#header');
		// check if the above element exits (only in new larry theme, if null use rc 0.7 default theme
		if (top_nav.height() == null) {
			top_nav = $('#roundcubeFrame').contents().find('#taskbar');
		} else {
			//top_in= top_margin-top_nav.height();
		}
		top_nav.remove();
		$('#roundcubeFrame').contents().find('#mainscreen').css('top', top_margin);
	} else {
		// correct top padding
		$('#roundcubeFrame').contents().find('#mainscreen').css('top', '50px');
	}
	// slide in roundcube nice
	$('#loader').fadeOut('slow');
	$('#roundcubeFrame').slideDown('slow');
	// remove email adresse
	$('#roundcubeFrame').contents().find('.username').remove();

});
