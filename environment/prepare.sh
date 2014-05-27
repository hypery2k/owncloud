#!/bin/sh

# ownCloud - prepare environment
#
# author Martin Reinhardt
#
# usage $0 -h -o OC50 -r RC07 -d mysql or $0 --help --oc_version OC50 --rc_version RC07 --db_type mysql

PWD="`pwd`"
DIR_WWW=/var/www/oc_testing
DIR_OC_DEV=${PWD%/*}

# Text color variables
txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}$(tput setaf 7) #  white
txtrst=$(tput sgr0)             # Reset
info=${bldwht}*${txtrst}        # Feedback
pass=${bldblu}*${txtrst}
warn=${bldred}*${txtrst}
ques=${bldblu}?${txtrst}

echo
echo "$txtbld ============================================== $txtrst"
echo "$txtbld =   PREPARING OWNCLOUD INTEGRATION TESTING   = $txtrst"
echo "$txtbld ============================================== $txtrst"
echo 

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
OC_VERSION=""
RC_VERSION=""
DB_TYPE=""
HOST_URL=""


while [[ $# > 1 ]]
do
  key="$1"
  shift
  case $key in
    -h|--help)
      echo "usage $0 -h -o OC50 -r RC07 -d mysql -u http://localhost or $0 --help --oc_version OC50 --rc_version RC07 --db_type mysql --url http://localhost"
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
    -u|--url)        
      HOST_URL="$1"
      shift
      ;;
    *)
      echo "Unkown option"
      echo "usage $0 -h -o OC50 -r RC07 -d mysql -u http://localhost or $0 --help --oc_version OC50 --rc_version RC07 --db_type mysql --url http://localhost"
      exit 0
    ;;
  esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

echo "  Using following settings:"
echo "     ${txtund}OC_VERSION:${txtrst} ${OC_VERSION}"
echo "     ${txtund}RC_VERSION:${txtrst} ${RC_VERSION}"
echo "     ${txtund}DB_TYPE:${txtrst}    ${DB_TYPE}"
echo "     ${txtund}HOST_URL:${txtrst}    ${HOST_URL}"
echo


# SETUP OWNCLOUD
echo "  ==> Preparing owncloud setup"

# clean up first
rm -r $DIR_WWW/$DB_TYPE

DIR_OC_CUR=$DIR_WWW/$DB_TYPE/$OC_VERSION
DIR_RC_CUR=$DIR_WWW/$DB_TYPE/$RC_VERSION
DIR_OC_APPS=$DIR_OC_CUR/apps
DIR_OC_DATA=$DIR_OC_CUR/data
DIR_OC_APP_RC=$DIR_OC_APPS/roundcube
DIR_OC_APP_SC=$DIR_OC_APPS/storage-charts

#create all needed directories
mkdir $DIR_WWW/$DB_TYPE
mkdir $DIR_OC_CUR
mkdir $DIR_RC_CUR
mkdir $DIR_OC_APPS
mkdir $DIR_OC_DATA
mkdir $DIR_OC_APP_RC
mkdir $DIR_OC_APP_SC


cp -rp owncloud_releases/$OC_VERSION/* DIR_OC_CUR
cp -rp roundcube_releases/$RC_VERSION/* DIR_RC_CUR

# prepare roundcube app
# TODO testdata in db
cd $DIR_OC_DEV
echo "  ==> copy app folder"
cp -r $DIR_OC_DEV/roundcube/src/main/php/* $DIR_OC_APP_RC
cp -r $DIR_OC_DEV/storage-charts/src/main/php/* $DIR_OC_APP_SC

echo "  ==> Directory listing for roundcube:"
ls -lisah $DIR_OC_APP_RC*
echo
echo "  ==> Directory listing for storage-charts:"
ls -lisah $DIR_OC_APP_SC*
echo


echo "  ==> Setting up Directory rights"
chmod -R 777 $DIR_WWW

echo "  ==> Done with general owncloud setup"

echo
echo "  ==> Preparing OwnCloud DB"
case $DB_TYPE in
  sqllite)        
    echo "  ==> Preparing SQLite DB"
    ;;
  mysql)        
    echo "  ==> Preparing MySQL DB"
    ;;
  ;;
esac

echo "  ==> Done with setup of test environment"
echo "$txtbld ============================================== $txtrst"
echo 

