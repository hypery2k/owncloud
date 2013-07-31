#!/bin/sh
cd bin

# Prepare Selenium
mkdir sausage && cd sausage
curl -s https://raw.github.com/jlipps/sausage-bun/master/givememysausage.php | SAUCE_USERNAME=mreinhardt SAUCE_ACCESS_KEY=28125823-d5a7-4ffe-a29b-f2976cb8d473 php
cd ..

cd ..
# SETUP OWNCLOUD
echo "Preparing owncloud setup"

VER_OC45="4.5.13"
VER_OC5="5.0.9"

DIR_OC_MYSQL="/var/www/mysql/"
DIR_OC_MYSQL_45=$DIR_OC_MYSQL$VER_OC45"/"
DIR_OC_MYSQL_5=$DIR_OC_MYSQL$VER_OC5"/"
DIR_OC_SQLLITE="/var/www/sqllite/"
DIR_OC_SQLLITE_45=$DIR_OC_SQLLITE$VER_OC45"/"
DIR_OC_SQLLITE_5=$DIR_OC_SQLLITE$VER_OC5"/"
DIR_OC_DEV=/tmp/owncloud_dev/

sudo mkdir $DIR_OC_MYSQL
sudo mkdir $DIR_OC_MYSQL_45
sudo mkdir $DIR_OC_MYSQL_45"apps"
sudo mkdir $DIR_OC_MYSQL_45"apps/roundcube"
sudo mkdir $DIR_OC_MYSQL_45"data"
sudo mkdir $DIR_OC_MYSQL_5
sudo mkdir $DIR_OC_MYSQL_5"apps"
sudo mkdir $DIR_OC_MYSQL_5"apps/roundcube"
sudo mkdir $DIR_OC_MYSQL_5"data"
sudo mkdir $DIR_OC_SQLLITE
sudo mkdir $DIR_OC_SQLLITE_45
sudo mkdir $DIR_OC_SQLLITE_45"apps"
sudo mkdir $DIR_OC_SQLLITE_45"apps/roundcube"
sudo mkdir $DIR_OC_SQLLITE_45"data"
sudo mkdir $DIR_OC_SQLLITE_5
sudo mkdir $DIR_OC_SQLLITE_5"apps"
sudo mkdir $DIR_OC_SQLLITE_5"apps/roundcube"
sudo mkdir $DIR_OC_SQLLITE_5"data"

sudo cp -rp travis_ci/owncloud_releases/$VER_OC45 $DIR_OC_MYSQL_45
sudo cp -rp travis_ci/owncloud_releases/$VER_OC45 $DIR_OC_SQLLITE_45
sudo cp -rp travis_ci/owncloud_releases/$VER_OC5 $DIR_OC_MYSQL_5
sudo cp -rp travis_ci/owncloud_releases/$VER_OC5 $DIR_OC_SQLLITE_5
sudo cp -rp travis_ci/roundcube_releases/0.7.3 /var/www/roundcubemail-0.7.3
sudo cp -rp travis_ci/roundcube_releases/0.8.2 /var/www/roundcubemail-0.8.2

# prepare roundcube app
# TODO testdata in db
sudo cd $DIR_OC_DEV
sudo git clone https://github.com/hypery2k/owncloud.git
echo "copy current app folder"
sudo cp -r $DIR_OC_DEV"owncloud/apps/roundcube/src" $DIR_OC_MYSQL_45"apps/roundcube"
sudo ls -lisah $DIR_OC_MYSQL_45"apps/roundcube/*"
sudo cp -r $DIR_OC_DEV"owncloud/apps/roundcube/src" $DIR_OC_MYSQL_5"apps/roundcube"
sudo ls -lisah $DIR_OC_MYSQL_45"apps/roundcube/*"
sudo cp -r $DIR_OC_DEV"owncloud/apps/roundcube/src" $DIR_OC_SQLLITE_45"apps/roundcube"
sudo ls -lisah $DIR_OC_MYSQL_45"apps/roundcube/*"
sudo cp -r $DIR_OC_DEV"owncloud/apps/roundcube/src" $DIR_OC_SQLLITE_5"apps/roundcube"
sudo ls -lisah $DIR_OC_MYSQL_45"apps/roundcube/*"

echo "Setting up Directory rights"
sudo chmod -R 777 $DIR_OC_MYSQL_45
sudo chmod -R 777 $DIR_OC_MYSQL_5
sudo chmod -R 777 $DIR_OC_SQLLITE_45
sudo chmod -R 777 $DIR_OC_SQLLITE_5
sudo chmod -R 777 /var/www/roundcubemail-0.7.3
sudo chmod -R 777 /var/www/roundcubemail-0.8.2

echo "Done with general owncloud setup"

echo " preparing OwnCloud db"
# admin Passw0rd!
sudo cp  travis_ci/sqllite/4.0.8/config.php /var/www/sqllite/4.0.8/config/
sudo cp  travis_ci/sqllite/4.0.8/owncloud.db /var/www/sqllite/4.0.8/data/

echo "Setting up IMAP test environment"
# setup dovecot
#Create temporary file with new line in place
sudo sed -e 's/mail_location.*=.*/mail_location = mbox:~\/mail:INBOX=\/var\/spool\/mail\/%u # (for mbox)/g' /etc/dovecot/dovecot.conf > /tmp/dovecot.conf
#Copy the new file over the original file
sudo mv -f /tmp/dovecot.conf /etc/dovecot/dovecot.conf
# start dovecot after config
sudo service dovecot start

# setup IMAP testuser, with password imap
sudo useradd imap1 -g users -d /home/imap1 -s /bin/bash -p imap -m
sudo useradd imap2 -g users -d /home/imap2 -s /bin/bash -p imap -m

echo "Done with setup of test environment"

