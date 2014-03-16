$(document).ready(function(){
    OC.Router.registerLoadedCallback(function(){
        var url = OC.Router.generate('roundcube_refresh');
        setInterval(function(){
            $.post(url);
        }, 300000);
    });
});
