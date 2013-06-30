#!/bin/sh
echo "Preparing MySQL environment"
# mysql setup
echo  'CREATE DATABASE IF NOT EXISTS  roundcubemail_073;'  > /tmp/rc_mysql073.sql
mysql roundcubemail_073 < /tmp/rc_mysql073.sql -u root -p root
mysql roundcubemail_073 < /var/www/roundcubemail-0.7.3/SQL/mysql.initial.sql -u root -p root
echo  'CREATE DATABASE IF NOT EXISTS  roundcubemail_082;'  > /tmp/rc_mysql082.sql
mysql roundcubemail_082 < /tmp/rc_mysql082.sql -u root -p root
mysql  -u root -p root roundcubemail_082 < /var/www/roundcubemail-0.8.2/SQL/mysql.initial.sql -u root -p root