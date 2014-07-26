
$(document).ready(function(){
    var url = OC.generateUrl('roundcuberefresh');
    setInterval(function(){
        $.post(url);
    }, 300000);
});
