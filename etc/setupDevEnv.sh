#!/bin/bash

echo "Packaging modules ...."
mvn clean package
echo "Packaging modules done."
echo
PWD="`dirname $0`"
echo "Setting up apache and db ...."
cd ${PWD}/../src/main/docker/app/
echo ----

echo "Using OwnCloud 6 and Roundcube 1.0 as default"
./setup_environment.sh  --oc_version OC60 --rc_version RC10 --db_type mysql --db_name oc_testing --db_user oc_testing --db_password password --workspace ${DEV_DIR}
echo "Setting up apache and db done."
echo