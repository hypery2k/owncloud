# ubuntu base image
FROM java:7
# install

ADD bootstrap.sh /usr/bin/
ADD prepareMySQL.sh /tmp/
RUN chmod +x /tmp/prepareMySQL.sh
ADD setup_environment.sh /tmp/prepare.sh
RUN chmod +x /tmp/prepare.sh
ADD nginx_ssl.conf /root/
ADD nginx.conf /root/

ENV DEBIAN_FRONTEND noninteractive
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

# mock imap
ADD mockimap.jar /root/
RUN java -jar /root/mockimap.jar &

# owncloud
RUN \
  apt-get clean && \
  apt-get update && \
  apt-get -f install -y bzip2 mysql-server unzip php5-cli php5-gd php5-pgsql php5-sqlite php5-mysqlnd php5-curl php5-intl php5-mcrypt php5-ldap php5-gmp php5-apcu php5-imagick php5-fpm smbclient nginx wget      
ADD php.ini /etc/php5/fpm/
RUN mkdir -p /tmp/oc_apps
RUN mkdir -p /tmp/etc
RUN mkdir -p /tmp/oc_apps/storagecharts2
RUN mkdir -p /tmp/oc_apps/roundcube
RUN mkdir -p /tmp/oc_apps/revealjs

# prepare apps
COPY . /tmp/oc_apps/
ADD etc/ /tmp/etc/
RUN \
  cd /tmp/oc_apps/ && \
  for z in *.zip; do unzip $z -d /tmp/oc_apps/; done 

# prepare mysql
RUN /tmp/prepareMySQL.sh oc_testing oc_testing password


RUN \
  cd /tmp/oc_apps/ && \
  /tmp/prepare.sh --oc_version ${oc_version} --rc_version ${rc_version} --db_type ${db_type}  && \
  chmod +x /usr/bin/bootstrap.sh

EXPOSE 80
EXPOSE 3306

# print versions
RUN java -version

ENTRYPOINT ["bootstrap.sh"]
