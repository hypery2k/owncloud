#!/bin/sh
echo "Preparing MySQL environment"
# mysql setup
CREATE DATABASE roundcubemail_073
mysql roundcubemail_073 < /var/www/roundcubemail-0.7.3/SQL/mysql.initial.sql -u root -p root
CREATE DATABASE roundcubemail_082
mysql roundcubemail_082 < /var/www/roundcubemail-0.8.2/SQL/mysql.initial.sql -u root -p root