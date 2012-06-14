<?php
require_once(OC::$APPSROOT . '/lib/base.php');
// Check if we are a user
if( !OC_User::isLoggedIn()){
	header( "Location: ".OC_Helper::linkTo( '', 'index.php' ));
	exit();
}
// check if app bookmark is enabled, since we need this app
if (!OC_App::isEnabled('bookmarks')){
	OC_Log::write('core','RoundCube can\'t be installed because the Bookmarks App isn\'t enabled',OC_Log::ERROR);
	header( "Location: ".OC_Helper::linkTo( '', 'index.php' ));
	exit();
}

// Load our style
OC_Util::addStyle('roundcube', 'base');
// add neede JS
OC_Util::addScript('','jquery-1.7.2.min');
OC_Util::addScript('roundcube','modernizr');

// add new navigation entry
OC_App::setActiveNavigationEntry("roundcube_index");


$tmpl = new OC_TEMPLATE("roundcube", "mail", "user");
$tmpl-> printpage();
?>