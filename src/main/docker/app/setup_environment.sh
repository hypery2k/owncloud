#!/bin/bash

# ownCloud - prepare environment
#
# author Martin Reinhardt
#
# usage -o OC70 -r RC10 -d mysql or --oc_version OC70 --rc_version RC10 --db_type mysql --db_name oc_testing --db_user root --db_password password --workspace /tmp

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
DIR_OC_DEV=${PWD}


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

# clean up first
rm -r ${DIR_WWW}/${DB_TYPE}/*

DIR_OC_CUR=${DIR_WWW}/owncloud
DIR_RC_CUR=${DIR_WWW}/roundcube
DIR_OC_APPS=${DIR_OC_CUR}/apps
DIR_OC_DATA=${DIR_OC_CUR}/data
DIR_OC_APP_RJ=$DIR_OC_APPS/revealjs
DIR_OC_APP_RC=$DIR_OC_APPS/roundcube
DIR_OC_APP_SC=$DIR_OC_APPS/storagecharts2

#create all needed directories
mkdir -p ${DIR_OC_CUR}
mkdir -p ${DIR_RC_CUR}
mkdir -p ${DIR_RC_CUR}/logs
mkdir -p ${DIR_RC_CUR}/temp
mkdir -p ${DIR_OC_APPS}
mkdir -p ${DIR_OC_DATA}
touch -p ${DIR_OC_DATA}/owncloud.log
mkdir -p ${DIR_OC_APP_RC}
mkdir -p ${DIR_OC_APP_RJ}
mkdir -p ${DIR_OC_APP_SC}

case ${OC_VERSION} in
  OC_LATEST)        
    echo "  ==> Preparing download of latest development master" 
    wget https://github.com/owncloud/core/archive/master.zip --no-check-certificate 
    unzip master.zip
    DIR_TMP_WORK_CUR=${PWD}
    cp -rp ${DIR_TMP_WORK_CUR}/core-master/*  ${DIR_OC_CUR}  
    cd ${DIR_OC_CUR} && chmod +x build/*.sh
    ./prepareTests.sh -d ${DB_TYPE} -n ${DB_NAME} -u ${DB_USER} -p ${DB_PASS} -p password
    cp -rp ${DIR_TMP_WORK_CUR}/owncloud_releases/${OC_VERSION}/config/* ${DIR_OC_CUR}/config   
    cd ${DIR_TMP_WORK_CUR}
    ;; 
  OC80)    	
  	wget https://download.owncloud.org/community/owncloud-8.0.0.tar.bz2 -P /tmp/
  	tar -C ${DIR_OC_CUR} -xvf /tmp/owncloud-7.0.4.tar.bz2
    ;;
  OC70)  
  	wget https://download.owncloud.org/community/owncloud-7.0.4.tar.bz2 -P /tmp/
  	tar -C ${DIR_OC_CUR} -xvf /tmp/owncloud-7.0.4.tar.bz2
    ;; 
  OC60)    
  	wget https://download.owncloud.org/community/owncloud-6.0.5.tar.bz2 -P /tmp/
  	tar -C ${DIR_OC_CUR} -xvf /tmp/owncloud-7.0.4.tar.bz2
    ;;  
esac

chown -R www-data:www-data ${DIR_OC_CUR}
cp -rp etc/${OC_VERSION}/* ${DIR_OC_CUR}/

echo "  ==> Directory listing for owncloud:"
ls -lisah ${DIR_OC_CUR}*


case ${RC_VERSION} in
  RC11)  
  	wget http://sourceforge.net/projects/roundcubemail/files/roundcubemail/1.1.0/roundcubemail-1.1.0-complete.tar.gz/download -P /tmp/
    tar -C ${DIR_RC_CUR} -xvzf /tmp/download
    ;;  
  RC10)  
  	wget http://sourceforge.net/projects/roundcubemail/files/roundcubemail/1.0.5/roundcubemail-1.0.5.tar.gz/download -P /tmp/
    tar -C ${DIR_RC_CUR} -xvzf /tmp/download
    ;;  
  RC09)  
  	wget http://sourceforge.net/projects/roundcubemail/files/roundcubemail/0.9.5/roundcube-framework-0.9.5.tar.gz/download -P /tmp/
    tar -C ${DIR_RC_CUR} -xvzf /tmp/download
    ;;  
  RC08) 
  	wget http://sourceforge.net/projects/roundcubemail/files/roundcubemail/0.8.7/roundcubemail-0.8.7.tar.gz/download -P /tmp/
    tar -C ${DIR_RC_CUR} -xvzf /tmp/download 
    ;;  
  RC07)  
  	wget http://sourceforge.net/projects/roundcubemail/files/roundcubemail/0.7.2/roundcubemail-0.7.2.tar.gz/download -P /tmp/
    tar -C ${DIR_RC_CUR} -xvzf /tmp/download
    ;;  
esac

cp -rp etc/${RC_VERSION}/* ${DIR_RC_CUR}/

echo "  ==> Directory listing for roundcube:"
ls -lisah ${DIR_RC_CUR}*



# prepare roundcube app

cd ${DIR_OC_DEV}
echo "  ==> copy app folder"
cp -r ${DIR_OC_DEV}/roundcube/* ${DIR_OC_APP_RC}
cp -r ${DIR_OC_DEV}/storagecharts2/* ${DIR_OC_APP_SC}
cp -r ${DIR_OC_DEV}/revealjs/* ${DIR_OC_APP_RJ}

echo "  ==> Directory listing for app-folder of roundcube:"
ls -lisah ${DIR_OC_APP_RC}*
echo
echo "  ==> Directory listing for app-folder of storage-charts:"
ls -lisah ${DIR_OC_APP_SC}*
echo


echo "  ==> Setting up config"

# move settings template
mv ${DIR_OC_CUR}/config/config_${DB_TYPE}.php ${DIR_OC_CUR}/config/config.php
chown -R www-data ${DIR_OC_CUR}/config
touch ${DIR_OC_DATA}/.ocdata

echo "  ==> Setting up Directory rights"
chmod -R 777 ${DIR_WWW}
chown -R www-data ${DIR_WWW}/${DB_TYPE}/
chmod -R 770 ${DIR_OC_DATA}
chmod -R 770 ${DIR_OC_CUR}/config/
chmod 770 ${DIR_OC_CUR}/config/

echo "  ==> Done with general owncloud setup"
echo
echo "  ==> Preparing OwnCloud DB"

# Detect paths
MYSQL=$(which mysql)
AWK=$(which awk)
GREP=$(which grep)


case ${DB_TYPE} in
  sqllite)        
    echo "  ==> Preparing SQLite DB"
    ;;
  mysql)        
    echo "  ==> Preparing MySQL DB"    
	# clean up first
	TABLES=$($MYSQL -u${DB_USER} -p${DB_PASS} ${DB_NAME} -e 'show tables' | $AWK '{ print $1}' | $GREP -v '^Tables' )
	for t in $TABLES
	do
		echo "    Deleting $t table from $MDB database..."
		$MYSQL -u${DB_USER} -p${DB_PASS} ${DB_NAME} -e "drop table $t;"
	done
	echo "  ==> Setting up MySQL DB"  
	echo "  	owncloud:  "
    $MYSQL -u${DB_USER} -p${DB_PASS} ${DB_NAME} < /tmp/etc/mysql/${OC_VERSION}/create_db.sql
   	echo "  	roundcube:  "
    $MYSQL -u${DB_USER} -p${DB_PASS} ${DB_NAME} < /tmp/etc/mysql/${RC_VERSION}/create_db.sql
    ;;
esac

echo "  ==> Done with setup of test environment"
echo " ============================================== "
echo 

