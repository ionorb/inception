#!/bin/bash

set -x

# Function to check if MariaDB is ready
wait_for_db() {
	echo "($?)" "Waiting for MariaDB..."
	until mysqladmin ping -h"mariadb" --silent; do
		echo "($?)" "Waiting for MariaDB..."
		sleep 2
	done
	echo "MariaDB up and running"
}

# Wait for MariaDB to be ready
wait_for_db
sleep 30

# Check if wp-config.php exists and create the file
if [ ! -f "${WP_PATH}/wp-config.php" ]; then
	echo "Creating wp-config.php..."
	su -s /bin/sh -c "wp config create --dbname=${DB_NAME} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=mariadb:3306 --path=${WP_PATH}" www-data
	chmod 644 ${WP_PATH}/wp-config.php
fi

# Check if WordPress is installed and install
if ! $(su -s /bin/sh -c "wp core is-installed --path=${WP_PATH}" www-data); then
	# Install WordPress
	su -s /bin/sh -c "wp core install --url=${DOMAIN_NAME} --title="INCEPTION-WEBSITE" --admin_user="manager" --admin_password=${MYSQL_ROOT_PASSWORD} --admin_email="yridgway@student.42.fr" --path=${WP_PATH}" www-data
	# Create a second user
	su -s /bin/sh -c "wp user create yoel yoel@${DOMAIN_NAME} --role=author --user_pass=${MYSQL_PASSWORD} --path=${WP_PATH}" www-data
fi

# Start php-fpm in the foreground
echo "Starting FPM"
exec php-fpm7.4 -F
