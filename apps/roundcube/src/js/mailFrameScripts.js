var buffer = 20; //scroll bar buffer
	
function pageY(elem) {
    return elem.offsetParent ? (elem.offsetTop + pageY(elem.offsetParent)) : elem.offsetTop;
}
	
function resizeIframe() {
    var height = document.documentElement.clientHeight;
    height -= pageY(document.getElementById('roundcubeFrame'))+ buffer ;
    height = (height < 0) ? 0 : height;
    document.getElementById('roundcubeFrame').style.height = height + 'px';
	// fix scrollbar issue
	$('#content').css('overflow','hidden');
	$('#content').css('height','+ height+');
	width=$('#content').css('width');
	$('#content').css('width','+ width +');
	
}

$('#roundcubeFrame').load(function() {
	resizeIframe();

	var mainscreen = $('#roundcubeFrame').contents().find('#mainscreen');
    // remove header line, includes about line and
    var top_line = $('#roundcubeFrame').contents().find('#topline');
    // correct top padding
    var top_margin=10;
    try{    
            var top_nav = $('#roundcubeFrame').contents().find('#topnav');
            // check if the above element exits (only in new larry theme, if null use rc 0.7 default theme
            // TODO refactor and move theme check
            if(top_nav.height()!=null){
                    top_margin= 10;
            } else {
                    top_margin= parseInt(mainscreen.css('top'),10)-top_line.height();
            }
    } catch (e) {}
    top_line.remove();

    // remove logout button
    $('#roundcubeFrame').contents().find('.button-logout').remove();
    
    if($('#disable_header_nav').val()) {

            var top_nav = $('#roundcubeFrame').contents().find('#topnav');
            // check if the above element exits (only in new larry theme, if null use rc 0.7 default theme
            if(top_nav.height()==null){
                    top_nav = $('#roundcubeFrame').contents().find('#taskbar');
            } else {
                    //top_in= top_margin-top_nav.height();
            }
            top_nav.remove();
    }
	// correct top padding
	$('#roundcubeFrame').contents().find('#mainscreen').css('top',top_margin);

	$('#loader').fadeOut('slow');
	$('#roundcubeFrame').slideDown('slow');
	
});
