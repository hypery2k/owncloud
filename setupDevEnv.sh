#!/bin/bash

echo "Packaging modules ...."
mvn clean package
echo "Packaging modules done."
echo
echo "Setting up apache and db ...."
cd webtest/src/main/docker/app/
echo ----

echo "Using OwnCloud 8 and Roundcube 1.1 as default"
./setup_environment.sh  --oc_version OC80 --rc_version RC11 --db_type mysql --db_name oc_testing --db_user oc_testing --db_password password --workspace ${DEV_DIR}
echo "Setting up apache and db done."
echo