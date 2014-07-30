$(document).ready(function() {
	if (OC.Router) {
		OC.Router.registerLoadedCallback(function() {
			var url = OC.Router.generate('roundcube_refresh');
			setInterval(function() {
				$.post(url);
			}, 30000);
		});
		// starting with OC7 OC.Router was removed
	} else {
		var url = OC.generateUrl('roundcube_refresh');
		setInterval(function() {
			$.post(url);
		}, 30000);
	}
});
