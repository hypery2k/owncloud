// declare namespace

var Roundcube = Roundcube || {};

/**
 * Set client side refresh job
 */
Roundcube.routes = function() {
  if (OC.currentUser) {
    if (Roundcube.refreshInterval) {
      if (OC.Router) {
	OC.Router.registerLoadedCallback(function() {
	  var url = OC.Router.generate('roundcube_refresh');
	  Roundcube.refresh = setInterval(function() {
	    $.post(url);
	  }, Roundcube.refreshInterval * 1000);
	  return true;
	});
	// starting with OC7 OC.Router was removed
      } else {
	var url = OC.generateUrl('apps/roundcube/' + 'refresh');
	Roundcube.refresh = setInterval(function() {
	  if (OC.currentUser) {
	    $.post(url);
	  } else {
	    // if user is null end up refresh (logged out)
	    clearTimeout(Roundcube.refresh);
	  }
	}, Roundcube.refreshInterval * 1000);
	return true;
      }
    }
  } else {
    // if user is null end up refresh (logged out)
    clearTimeout(Roundcube.refresh);
    return false;
  }
}

$(document).ready(function() {
  Roundcube.routes();
});
