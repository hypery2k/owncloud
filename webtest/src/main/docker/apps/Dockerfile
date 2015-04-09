# ubuntu base image
FROM java:7
# prepare files
RUN mkdir -p /tmp/oc_apps
RUN mkdir -p /tmp/etc
RUN mkdir -p /tmp/oc_apps/storagecharts2
RUN mkdir -p /tmp/oc_apps/roundcube
RUN mkdir -p /tmp/oc_apps/revealjsh
ADD php.ini /etc/php5/fpm/
ADD mockimap.jar /root/
ADD etc/ /tmp/etc/
ADD bootstrap.sh /usr/bin/
ADD prepareMySQL.sh /tmp/
ADD prepareNginx.sh /tmp/
ADD setup_environment.sh /tmp/prepare.sh
RUN chmod +x /tmp/prepareMySQL.sh
RUN chmod +x /tmp/prepareNginx.sh
RUN chmod +x /usr/bin/bootstrap.sh
RUN chmod +x /tmp/prepare.sh

# prepare env
ENV DEBIAN_FRONTEND noninteractive
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

# use google DNS
RUN echo 'nameserver 8.8.8.8' > /etc/resolv.conf; echo 'nameserver 8.8.4.4' >> /etc/resolv.conf ;

# owncloud
RUN \
  apt-get clean && \
  apt-get update && \
  apt-get -f install -y vim openssh-server net-tools bzip2 mysql-server unzip php5-cli php5-gd php5-pgsql php5-sqlite php5-mysqlnd php5-curl php5-intl php5-mcrypt php5-ldap php5-gmp php5-apcu php5-imagick php5-fpm smbclient nginx wget      


# prepare apps
COPY . /tmp/oc_apps/
RUN \
  cd /tmp/oc_apps/ && \
  for z in *.zip; do unzip $z -d /tmp/oc_apps/; done 

# prepare mysql
RUN /tmp/prepareMySQL.sh oc_testing oc_testing password


RUN /tmp/prepare.sh --oc_version ${oc_version} --rc_version ${rc_version} --db_type ${db_type}

RUN /tmp/prepareNginx.sh


# setup phpmyadmin
RUN \
  /tmp/prepareMySQL.sh phpmyadmin oc_testing password && \
  apt-get install phpmyadmin --yes --force-yes && \
  cp /tmp/etc/phpmyadmin.conf /etc/phpmyadmin/config-db.php
RUN \
  ln -s /usr/share/phpmyadmin /var/www/phpmyadmin

EXPOSE 49080

# print versions
RUN java -version

ENTRYPOINT ["bootstrap.sh"]
