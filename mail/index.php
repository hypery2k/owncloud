<?php
require_once(OC::$APPSROOT . '/lib/base.php');
OCP\User::checkLoggedIn();
OCP\App::checkAppEnabled('bookmarks');
OCP\App::setActiveNavigationEntry("mail_index");


$tmpl = new OCP\TEMPLATE("mail", "mail", "user");
$tmpl-> printpage();
?>