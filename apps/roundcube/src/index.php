<?php
require_once(OC::$APPSROOT . '/lib/base.php');
// Check if we are a user
if( !OC_User::isLoggedIn()){
	header( "Location: ".OC_Helper::linkTo( '', 'index.php' ));
	exit();
}
if (!OCP\App::isEnabled('bookmarks')){
	OC_Log::write('core','RoundCube can\'t be installed because the Bookmarks App isn\'t enabled',OC_Log::ERROR);
	header( "Location: ".OC_Helper::linkTo( '', 'index.php' ));
	exit();
}
OCP\App::setActiveNavigationEntry("roundcube_index");


$tmpl = new OCP\TEMPLATE("roundcube", "mail", "user");
$tmpl-> printpage();
?>