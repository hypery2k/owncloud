FROM		ubuntu:14.04
MAINTAINER	Martin Reinhardt (contact@martinreinhardt-online.de)

ADD         bootstrap.sh /usr/bin/
ADD         nginx_ssl.conf /root/
ADD         nginx.conf /root/

ENV         DEBIAN_FRONTEND noninteractive
RUN         dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

RUN         apt-get update && \
            apt-get install -y default-jre php5-cli php5-gd php5-pgsql php5-sqlite php5-mysqlnd php5-curl php5-intl php5-mcrypt php5-ldap php5-gmp php5-apcu php5-imagick php5-fpm smbclient nginx wget

CMD			["./prepare.sh"]         

ADD         php.ini /etc/php5/fpm/
ADD         cron.conf /etc/oc-cron.conf
RUN         crontab /etc/oc-cron.conf

EXPOSE      80

ENTRYPOINT  ["bootstrap.sh"]
