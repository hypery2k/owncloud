#!/bin/bash

echo "Packaging modules ...."
mvn clean package
echo "Packaging modules done."
echo

echo "Setting up apache and db ...."
cd environment
echo "Using OwnCloud 6 and Roundcube 1.0 as default"
PWD="`pwd`"
DEV_DIR=${PWD%/*}
./prepare.sh --oc_version OC60 --rc_version RC10 --db_type mysql --db_name oc_testing --db_user oc_testing --db_password password --workspace ${DEV_DIR}
echo "Setting up apache and db done."
echo