$(document).ready(function() {
	if (OC.Router) {
		OC.Router.registerLoadedCallback(function() {
			var url = OC.Router.generate('roundcube_refresh');
			setInterval(function() {
				$.post(url);
			}, Roundcube.refreshInterval*1000);
		});
		// starting with OC7 OC.Router was removed
	} else {
                var url = OC.generateUrl('apps/roundcube/'+'refresh');
		setInterval(function() {
			$.post(url);
		}, Roundcube.refreshInterval*1000);
	}
});
