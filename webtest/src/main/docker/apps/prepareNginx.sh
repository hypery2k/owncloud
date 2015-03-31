#!/bin/sh

touch /var/log/nginx/access.log
touch /var/log/nginx/error.log
touch /var/www/owncloud/data/owncloud.log

if [ -z "$SSL_CERT" ]; then
    echo "\nCopying nginx.conf without SSL support..\n"
    cp /tmp/etc/nginx.conf /etc/nginx/nginx.conf
else
    echo "\nCopying nginx.conf with SSL support..\n"
    sed -i "s#-x-replace-cert-x-#$SSL_CERT#" /tmp/etc/nginx_ssl.conf
    sed -i "s#-x-replace-key-x-#$SSL_KEY#" /tmp/etc/nginx_ssl.conf
    cp /tmp/etc/nginx_ssl.conf /etc/nginx/nginx.conf
fi
chown -R www-data:www-data /var/www/owncloud 