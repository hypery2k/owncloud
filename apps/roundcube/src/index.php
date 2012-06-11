<?php
require_once(OC::$APPSROOT . '/lib/base.php');
OCP\User::checkLoggedIn();
OCP\App::checkAppEnabled('bookmarks');
OCP\App::setActiveNavigationEntry("roundcube_index");


$tmpl = new OCP\TEMPLATE("roundcube", "roundcube", "user");
$tmpl-> printpage();
?>