# ubuntu base image
FROM ubuntu:14.04
# install

ADD bootstrap.sh /usr/bin/
ADD setup_environment.sh /tmp/prepare.sh
RUN chmod +x /tmp/prepare.sh
ADD nginx_ssl.conf /root/
ADD nginx.conf /root/

ENV DEBIAN_FRONTEND noninteractive
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

RUN cd /root && wget http://www.webmin.com/jcameron-key.asc && apt-key add jcameron-key.asc
RUN echo deb http://download.webmin.com/download/repository sarge contrib >> /etc/apt/sources.list 
RUN http://webmin.mirror.somersettechsolutions.co.uk/repository sarge >> /etc/apt/sources.list 
RUN apt-get update

# webmin
RUN apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
RUN apt-get install webmin

# owncloud
RUN apt-get install -y default-jre php5-cli php5-gd php5-pgsql php5-sqlite php5-mysqlnd php5-curl php5-intl php5-mcrypt php5-ldap php5-gmp php5-apcu php5-imagick php5-fpm smbclient nginx wget      
ADD php.ini /etc/php5/fpm/
ADD cron.conf /etc/oc-cron.conf
RUN mkdir -p /tmp/oc_apps
RUN mkdir -p /tmp/oc_apps/storagecharts2
RUN mkdir -p /tmp/oc_apps/roundcube
RUN mkdir -p /tmp/oc_apps/revealjs
ADD oc_apps/ /tmp/oc_apps/
RUN crontab /etc/oc-cron.conf
RUN /tmp/prepare.sh --oc_version ${oc_version} --rc_version ${rc_version} --db_type ${db_type} 

EXPOSE 80

ENTRYPOINT ["bootstrap.sh"]
