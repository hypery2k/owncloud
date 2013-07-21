#!/bin/sh
echo "Preparing MySQL environment"
# mysql setup
echo "Preparing db for roundcube 0.7.3"
echo  'CREATE DATABASE IF NOT EXISTS  roundcubemail_073;'  | mysql -uroot
echo "Preparing initial data for roundcube 0.7.3"
cat /var/www/roundcubemail-0.7.3/SQL/mysql.initial.sql
# cat /var/www/roundcubemail-0.7.3/SQL/mysql.initial.sql | mysql -uroot
echo "Preparing db for roundcube 0.8.2"
echo  'CREATE DATABASE IF NOT EXISTS  roundcubemail_082;'  | mysql -uroot
echo "Preparing initial data for roundcube 0.8.2"
cat /var/www/roundcubemail-0.8.2/SQL/mysql.initial.sql
# cat  /var/www/roundcubemail-0.8.2/SQL/mysql.initial.sql | mysql -uroot
