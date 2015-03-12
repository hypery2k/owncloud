#!/bin/sh

java -jar /root/mockimap.jar --silent  &
/etc/init.d/php5-fpm restart  &
/etc/init.d/nginx restart  &
/etc/init.d/mysql restart  &

tail -F /var/log/nginx/*.log &
tail -F /var/www/owncloud/data/owncloud.log