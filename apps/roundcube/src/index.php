<?php
require_once(OC::$APPSROOT . '/lib/base.php');
// Check if we are a user
if( !OC_User::isLoggedIn()){
	header( "Location: ".OC_Helper::linkTo( '', 'index.php' ));
	exit();
}
// check if app bookmark is enabled, since we need this app
if (!OCP\App::isEnabled('bookmarks')){
	OC_Log::write('core','RoundCube can\'t be installed because the Bookmarks App isn\'t enabled',OC_Log::ERROR);
	header( "Location: ".OC_Helper::linkTo( '', 'index.php' ));
	exit();
}
// add new navigation entry
OCP\App::setActiveNavigationEntry("roundcube_index");


$tmpl = new OCP\TEMPLATE("roundcube", "mail", "user");
$tmpl-> printpage();
?>