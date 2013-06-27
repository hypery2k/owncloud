#!/bin/sh
echo "Preparing MySQL environment"
# mysql setup
mysql 'CREATE DATABASE IF NOT EXISTS  roundcubemail_073;'  -u root -p root
mysql roundcubemail_073 < /var/www/roundcubemail-0.7.3/SQL/mysql.initial.sql -u root -p root
mysql 'CREATE DATABASE IF NOT EXISTS roundcubemail_082;' -u root -p root
mysql roundcubemail_082 < /var/www/roundcubemail-0.8.2/SQL/mysql.initial.sql -u root -p root