<?php

//update from OC 3

$installedVersion = OCP\Config::getAppValue('roundcube', 'installed_version');
if (version_compare($installedVersion, '1.1', '<')) {
  // Migration stuff here

}
