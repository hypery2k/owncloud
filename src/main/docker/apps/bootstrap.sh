#!/bin/sh

touch /var/log/nginx/access.log
touch /var/log/nginx/error.log
touch /var/log/cron/owncloud.log

if [ -z "$SSL_CERT" ]; then
    echo "\nCopying nginx.conf without SSL support..\n"
    cp /root/nginx.conf /etc/nginx/nginx.conf
else
    echo "\nCopying nginx.conf with SSL support..\n"
    sed -i "s#-x-replace-cert-x-#$SSL_CERT#" /root/nginx_ssl.conf
    sed -i "s#-x-replace-key-x-#$SSL_KEY#" /root/nginx_ssl.conf
    cp /root/nginx_ssl.conf /etc/nginx/nginx.conf
fi
chown -R www-data:www-data /var/www/owncloud /owncloud
echo "Starting server..\n"

tail -F /var/log/nginx/*.log /var/log/cron/owncloud.log &

/usr/sbin/cron -f &
/etc/init.d/php5-fpm start
/etc/init.d/nginx start
