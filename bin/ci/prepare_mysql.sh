#!/bin/sh
echo "Preparing MySQL environment"
# mysql setup
echo  'CREATE DATABASE IF NOT EXISTS  roundcubemail_073;'  | mysql -uroot -proot
echo /var/www/roundcubemail-0.7.3/SQL/mysql.initial.sql | mysql -uroot -proot
echo  'CREATE DATABASE IF NOT EXISTS  roundcubemail_082;'  | mysql -uroot -proot
echo  /var/www/roundcubemail-0.8.2/SQL/mysql.initial.sql | mysql -uroot -proot
