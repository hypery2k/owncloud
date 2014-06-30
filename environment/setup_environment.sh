#!/bin/bash

# ownCloud - prepare environment
#
# author Martin Reinhardt
#
# usage -o OC50 -r RC07 -d mysql or --oc_version OC50 --rc_version RC07 --db_type mysql --db_name oc_testing --db_user root --db_password password --workspace /tmp

DIR_WWW=/var/www/oc_testing

echo
echo "=============================================="
echo "=   PREPARING OWNCLOUD INTEGRATION TESTING   ="
echo "=============================================="
echo 

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
OC_VERSION=""
RC_VERSION=""
DB_TYPE=""
DB_USER="oc_testing"
DB_PASS="password"
DB_NAME="oc_testing"
HOST_URL=""

# set current path as working dir (fallback)
PWD="`pwd`"
DIR_OC_DEV=${PWD%/*}


while [[ $# > 1 ]]
do
  key="$1"
  shift
  case $key in
    -h|--help)
      echo "usage $0 -h -o OC50 -r RC07 -d mysql --n oc_testing --i root --p password -u http://localhost -w /tmp or $0 --help --oc_version OC50 --rc_version RC07 --db_type mysql --db_name oc_testing --db_user root --db_password password  --url http://localhost --workspace /tmp"
      exit 0
      ;;
    -o|--oc_version)        
      OC_VERSION="$1"
      shift
      ;;
    -r|--rc_version)        
      RC_VERSION="$1"
      shift
      ;;
    -d|--db_type)        
      DB_TYPE="$1"
      shift
      ;;
    -n|--db_name)        
      DB_NAME="$1"
      shift
      ;;
    -i|--db_user)        
      DB_USER="$1"
      shift
      ;;
    -p|--db_password)        
      DB_PASS="$1"
      shift
      ;;
    -u|--url)        
      HOST_URL="$1"
      shift
      ;;
    -w|--workspace)        
      DIR_OC_DEV="$1"
      shift
      ;;
    *)
      echo "Unkown option"
      echo "usage $0 -h -o OC50 -r RC07 -d mysql -u http://localhost -w /tmp or $0 --help --oc_version OC50 --rc_version RC07 --db_type mysql --url http://localhost --workspace /tmp"
      exit 0
    ;;
  esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

echo "  Using following settings:"
echo "     OC_VERSION: ${OC_VERSION}"
echo "     RC_VERSION: ${RC_VERSION}"
echo "     DB_TYPE:    ${DB_TYPE}"
echo "     HOST_URL:   ${HOST_URL}"
echo


# SETUP OWNCLOUD
echo "  ==> Preparing owncloud setup"

echo "  ==> Directory listing of web testing folder:"
ls -lisah $DIR_WWW/$DB_TYPE/*

# clean up first
rm -r $DIR_WWW/$DB_TYPE/*

DIR_OC_CUR=$DIR_WWW/$DB_TYPE/$OC_VERSION
DIR_RC_CUR=$DIR_WWW/$DB_TYPE/$RC_VERSION
DIR_OC_APPS=$DIR_OC_CUR/apps
DIR_OC_DATA=$DIR_OC_CUR/data
DIR_OC_APP_RJ=$DIR_OC_APPS/revealjs
DIR_OC_APP_RC=$DIR_OC_APPS/roundcube
DIR_OC_APP_SC=$DIR_OC_APPS/storagecharts2

#create all needed directories
mkdir -p $DIR_WWW/$DB_TYPE
mkdir -p $DIR_OC_CUR
mkdir -p $DIR_RC_CUR
mkdir -p $DIR_RC_CUR/logs
mkdir -p $DIR_RC_CUR/temp
mkdir -p $DIR_OC_APPS
mkdir -p $DIR_OC_DATA
mkdir -p $DIR_OC_APP_RC
mkdir -p $DIR_OC_APP_RJ
mkdir -p $DIR_OC_APP_SC

case $OC_VERSION in
  OC_LATEST)        
    echo "  ==> Preparing clone of owncloud GIT"
    rm -r $DIR_OC_CUR  
    git clone https://github.com/owncloud/core $DIR_OC_CUR  
    cp -rp owncloud_releases/$OC_VERSION/config/* $DIR_OC_CUR/config   
    ;;  
  *)  
  	cp -rp owncloud_releases/$OC_VERSION/* $DIR_OC_CUR
    ;;
esac

echo "  ==> Directory listing for owncloud:"
ls -lisah $DIR_OC_CUR*

cp -rp roundcube_releases/$RC_VERSION/* $DIR_RC_CUR
echo "  ==> Directory listing for roundcube:"
ls -lisah $DIR_RC_CUR*

# prepare roundcube app
# TODO testdata in db

cd $DIR_OC_DEV
echo "  ==> copy app folder"
cp -r $DIR_OC_DEV/roundcube/target/classes/* $DIR_OC_APP_RC
cp -r $DIR_OC_DEV/storagecharts2/target/classes/* $DIR_OC_APP_SC
cp -r $DIR_OC_DEV/revealjs/target/classes/* $DIR_OC_APP_RJ

echo "  ==> Directory listing for app-folder of roundcube:"
ls -lisah $DIR_OC_APP_RC*
echo
echo "  ==> Directory listing for app-folder of storage-charts:"
ls -lisah $DIR_OC_APP_SC*
echo


echo "  ==> Setting up config"
# copy htaccess
#cp $DIR_OC_DEV/environment/owncloud_releases/$OC_VERSION/.htaccess ${DIR_OC_CUR}/.htaccess

# copy settings template
cp ${DIR_OC_CUR}/config/config_${DB_TYPE}.php ${DIR_OC_CUR}/config/config.php
chown -R www-data ${DIR_OC_CUR}/config
touch $DIR_OC_DATA/.ocdata

echo "  ==> Setting up Directory rights"
chmod -R 777 $DIR_WWW
chown -R www-data $DIR_WWW/$DB_TYPE/
chmod -R 770 $DIR_OC_DATA
chmod -R 770 ${DIR_OC_CUR}/config/
chmod 770 ${DIR_OC_CUR}/config/

echo "  ==> Done with general owncloud setup"
echo
echo "  ==> Preparing OwnCloud DB"

# Detect paths
MYSQL=$(which mysql)
AWK=$(which awk)
GREP=$(which grep)


case $DB_TYPE in
  sqllite)        
    echo "  ==> Preparing SQLite DB"
    ;;
  mysql)        
    echo "  ==> Preparing MySQL DB"    
	# clean up first
	TABLES=$($MYSQL -u$DB_USER -p$DB_PASS $DB_NAME -e 'show tables' | $AWK '{ print $1}' | $GREP -v '^Tables' )
	for t in $TABLES
	do
		echo "    Deleting $t table from $MDB database..."
		$MYSQL -u$DB_USER -p$DB_PASS $DB_NAME -e "drop table $t;"
	done
	echo "  ==> Setting up MySQL DB"  
	echo "  	owncloud:  "
    $MYSQL -u$DB_USER -p$DB_PASS $DB_NAME < $DIR_OC_DEV/environment/mysql/$OC_VERSION/create_db.sql
    $MYSQL -u$DB_USER -p$DB_PASS $DB_NAME -e "INSERT INTO oc_testing.oc6_appconfig (appid,configkey,configvalue) VALUES('roundcube','maildir','/oc_testing/mysql/$RC_VERSION/');"
	echo "  	roundcube:  "
    $MYSQL -u$DB_USER -p$DB_PASS $DB_NAME < $DIR_OC_DEV/environment/mysql/$RC_VERSION/create_db.sql
    ;;
esac

echo "  ==> Done with setup of test environment"
echo " ============================================== "
echo 

