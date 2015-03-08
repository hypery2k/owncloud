#!/bin/sh

tail -F /var/log/nginx/*.log &
tail -F /var/www/owncloud/data/owncloud.log &
