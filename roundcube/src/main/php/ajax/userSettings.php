<?php

// Check if we are a user
OCP\JSON::checkLoggedIn();
OCP\JSON::checkAppEnabled('roundcube');

// CSRF checks
OCP\JSON::callCheck();

return OC_RoundCube_App::saveUserSettings($_POST['appname'], OCP\User::getUser(), $_POST['rc_mail_username'], $_POST['rc_mail_password']);
