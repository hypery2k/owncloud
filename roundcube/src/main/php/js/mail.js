// declare namespace
var Roundcube = Roundcube || {};

/**
 * Fills height and width of window. (more precise than height: 100%; or width: 100%;)
 */
Roundcube.fillWindow = function(selector) {
  if (selector.length === 0) {
    return;
  }
  Roundcube.fillHeight(selector);
  var width = parseFloat($(window).width()) - selector.offset().left;
  selector.css('width', width + 'px');
  if (selector.outerWidth() > selector.width()) {
    selector.css('width', width - (selector.outerWidth() - selector.width()) + 'px');
  }
}

/**
 * Fills height of window. (more precise than height: 100%;)
 */
Roundcube.fillHeight = function(selector) {
  if (selector.length === 0) {
    return;
  }
  var height = parseFloat($(window).height()) - selector.offset().top;
  selector.css('height', height + 'px');
  if (selector.outerHeight() > selector.height()) {
    selector.css('height', height - (selector.outerHeight() - selector.height()) + 'px');
  }
}

/**
 * init js function during frame load
 */
$('#roundcubeFrame').ready(function() {
  Roundcube.iFrameReady();
});

/**
 * Js functions called if iframe loaded
 */
Roundcube.iFrameReady = function(selector) {
  $(window).resize(function() {
    if (Roundcube.logdebug) {
      console.log("Starting roundcube container resize ...");
    }
    Roundcube.fillWindow($('#roundcube_container'));
    Roundcube.iframe_loaded();
  });
  $('#roundcubeFrame').load(function() {
    if (Roundcube.logdebug) {
      console.log("Starting roundcube container resize ...");
    }
    Roundcube.fillWindow($('#roundcube_container'));
    Roundcube.iframe_loaded();
  });
  // check if the control menu from roundcube was disabled
  if ($('#disable_control_nav').val() === '1') {
    $('#roundcube_container').css('top', '3.5em');
  }

  // slide in roundcube nice with timeout to let iframe load
  $("#roundcubeLoader").fadeOut(2500, function() {
    $(window).resize();
    $('#roundcubeFrame').show();
    Roundcube.iframe_loaded();
  });
}

/**
 * callback js function during after iframe loaded completly
 */
Roundcube.iframe_loaded = function() {

  var mainscreen = $('#roundcubeFrame').contents().find('#mainscreen');
  // remove header line, includes about line and
  var top_line = $('#roundcubeFrame').contents().find('#topline');
  // correct top padding
  var top_margin = 10;

  var rc_version = '';
  var rc_theme = '';

  try {
    var top_nav = $('#roundcubeFrame').contents().find('#topnav');
    // check if the above element exits (only in new larry theme, if null
    // use rc 0.7 default theme

    if (top_nav.height() != null) {
      rc_theme = 'larry';

      var minimize_toggle = $('#roundcubeFrame').contents().find('.minmodetoggle');
      if (minimize_toggle.height() != null) {
	rc_version = "0-9";
      } else {
	rc_version = "0-8";
      }
    } else {
      rc_version = "0-7";
    }

    switch (rc_theme) {
      case "larry":
	top_margin = 10;
	// In larry theme with accounts plugin, we have to move the account
	// selection
	var acc_select = top_line.find('.username');
	if (acc_select) {
	  mainscreen.find('div#messagetoolbar').attr('id', 'ocrcMessagetoolbar');
	  var searchfilter = mainscreen.find('div#searchfilter');
	  // Quick n dirty for space
	  acc_select.appendTo(searchfilter);
	  searchfilter.css({
	    position : 'absolute',
	    top : '0px',
	    width : '160px',
	    right : '256px',
	    top : '7px'
	  });
	  searchfilter.find('select#rcmlistfilter').css('width', '158px');
	  searchfilter.find('a.menuselector').css('width', '158px');
	  searchfilter.find('span.handle').css('width', '120px');
	  var messagetoolbar = mainscreen.find('div#ocrcMessagetoolbar');
	  messagetoolbar.css({
	    left : '0',
	    right : '390px'
	  });
	  // Extend messagetoolbar, if fullwidth is specified
	  mainscreen.find('.fullwidth').css('right', '0px');
	  var toolbarselect = messagetoolbar.find('.toolbarselect');
	  toolbarselect.css('position', 'absolute');
	  toolbarselect.css('bottom', '6px');
	  toolbarselect.css('right', '3px');
	}
	break;
    }

    switch (rc_version) {
      case "0-7":
	rc_version = "0-7";
	top_margin = parseInt(mainscreen.css('top'), 10) - top_line.height();
	// fix layout button issue on roundcube 0.7
	$('#roundcubeFrame').contents().find('#messagetoolbar').css('padding', '20px 6px 5px 0px');
	$('#roundcubeFrame').contents().find('#messagetoolbar').css('z-index', '100');
	break;
      case "0-9":
	$('#roundcubeFrame').contents().find('body').removeAttr('class');
	$('#roundcubeFrame').contents().find('.minmodetoggle').remove();
	break;

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
    // check if the above element exits (only in new larry theme, if null
    // use rc 0.7 default theme
    if (top_nav.val() === undefined) {
      top_nav = $('#roundcubeFrame').contents().find('#taskbar');
    } else {
      // new theme settings goes here
    }
    top_nav.remove();
    $('#roundcubeFrame').contents().find('#mainscreen').css('top', top_margin);
  } else {
    if (top_nav.val() === undefined) {
      top_nav = $('#roundcubeFrame').contents().find('#taskbar');
      $('#roundcubeFrame').contents().find('#messagetoolbar').css('top', '0px');
      $('#roundcubeFrame').contents().find('#messagetoolbar').css('border', '0');
      $('#roundcubeFrame').contents().find('#mainscreen').css('top', '70px');
    } else {
      // new theme settings goes here
      // correct top padding
      $('#roundcubeFrame').contents().find('#mainscreen').css('top', '50px');
    }
  }

  // remove email adresse
  $('#roundcubeFrame').contents().find('.username').remove();

  // RC only checks for visibility of the preview
  // window. However, as with start with display:none for the
  // entire frame, the preview window is indeed not visible at
  // the start when RC initializes itself.
  //
  // However, this seems to be a Firefox-only problem.
  var mailPrev = $('#roundcubeFrame').contents().find('#mailpreviewframe');
  if (mailPrev.length && mailPrev.css('display') != 'none') {
    $('#roundcubeFrame')[0].contentWindow.rcmail.set_env('contentframe', 'messagecontframe');
  }

};
