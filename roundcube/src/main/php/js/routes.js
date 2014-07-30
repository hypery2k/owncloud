$(document).ready(function() {
	OC.Router.registerLoadedCallback(function() {
		var url;
		if (OC.Router) {
			url = OC.Router.generate('roundcube_refresh');
		} else {
			url = OC.generateUrl('roundcube_refresh');
		}
		setInterval(function() {
			$.post(url);
		}, 30000);
	});
});
