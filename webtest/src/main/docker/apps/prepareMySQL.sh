#!/bin/bash

DB_NAME=$1
DB_USER=$2
DB_PASS=$3

# disable error log
sed 's/^log_error/# log_error/' -i /etc/mysql/my.cnf

# listen on all interfaces
cat > /etc/mysql/conf.d/mysql-listen.cnf <<EOF
[mysqld]
bind = 0.0.0.0
EOF

# Fixing StartUp Porblems with some DNS Situations and Speeds up the stuff
# http://www.percona.com/blog/2008/05/31/dns-achilles-heel-mysql-installation/
cat > /etc/mysql/conf.d/mysql-skip-name-resolv.cnf <<EOF
[mysqld]
skip_name_resolve
EOF

# fix permissions and ownership of /var/lib/mysql
mkdir -p -m 700 /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql

# fix permissions and ownership of /run/mysqld
mkdir -p -m 0755 /run/mysqld
chown -R mysql:root /run/mysqld

/etc/init.d/mysql restart

# create new user / database
if [ -n "${DB_USER}" -o -n "${DB_NAME}" ]; then
	
	echo "create new user / database..."
	# wait for mysql server to start (max 30 seconds)
	timeout=30
	while ! /usr/bin/mysqladmin -u root status >/dev/null 2>&1
	do
		timeout=$(($timeout - 1))
		if [ $timeout -eq 0 ]; then
			echo "Could not connect to mysql server. Aborting..."
			exit 1
		fi
		sleep 1
	done
	
	if [ -n "${DB_NAME}" ]; then
		echo "Creating database ${DB_NAME}..."
		mysql --defaults-file=/etc/mysql/debian.cnf \
			-e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\` DEFAULT CHARACTER SET \`utf8\` COLLATE \`utf8_unicode_ci\`;"
		if [ -n "${DB_USER}" ]; then
			echo "Creating user ${DB_USER}..."
			echo "Granting access to database \"$DB_USER\" for user \"${DB_USER}\"..."
			mysql --defaults-file=/etc/mysql/debian.cnf \
				-e "GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '${DB_USER}' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;"
		fi
	fi
fi