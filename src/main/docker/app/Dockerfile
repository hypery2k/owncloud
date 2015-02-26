# ubuntu base image
FROM ubuntu:14.04
# install

ADD bootstrap.sh /usr/bin/
ADD setup_environment.sh /tmp/prepare.sh
ADD nginx_ssl.conf /root/
ADD nginx.conf /root/

ENV DEBIAN_FRONTEND noninteractive
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

RUN apt-get update
RUN apt-get install -y default-jre php5-cli php5-gd php5-pgsql php5-sqlite php5-mysqlnd php5-curl php5-intl php5-mcrypt php5-ldap php5-gmp php5-apcu php5-imagick php5-fpm smbclient nginx wget      

ADD php.ini /etc/php5/fpm/
ADD cron.conf /etc/oc-cron.conf
RUN mkdir -p /tmp/oc_apps
RUN mkdir -p /tmp/oc_apps/storagecharts2
RUN mkdir -p /tmp/oc_apps/roundcube
RUN mkdir -p /tmp/oc_apps/revealjs
ADD oc_apps/ /tmp/oc_apps/
RUN crontab /etc/oc-cron.conf
RUN /tmp/prepare.sh

EXPOSE 80

ENTRYPOINT ["bootstrap.sh"]
