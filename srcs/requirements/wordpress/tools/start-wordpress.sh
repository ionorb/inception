#!/bin/bash


# Function to check if MariaDB is ready
wait_for_db() {
	echo "($?)" "Waiting for MariaDB..."
	until mysqladmin ping -h"mariadb" --silent; do
		echo "($?)" "Waiting for MariaDB..."
		sleep 2
	done
	echo "MariaDB up and running"
}

# Function to check if wordpress is installed
check_for_wordpress() {
	if ! $(su -s /bin/sh -c 'wp core is-installed --path="$WP_PATH"' www-data); then
		# Install WordPress
		su -s /bin/sh -c 'wp core install --url="yridgway.42.fr" --title="INCEPTION-WEBSITE" --admin_user="manager" --admin_password="password" --admin_email="yridgway@student.42.fr" --path="$WP_PATH"' www-data
		# Create a second user
		su -s /bin/sh -c 'wp user create yoel yoel@yridgway.42.fr --role=author --user_pass=password --path="$WP_PATH"' www-data
	fi
}

# Wait for MariaDB to be ready
wait_for_db

# export Path to WordPress
export WP_PATH="/var/www/html"

# Create the wp-config.php file
wp --allow-root config create --dbname=wordpress --dbuser=dbuser --dbpass=dbpass --dbhost=mariadb:3306 --path="$WP_PATH"

# Check if WordPress is installed
check_for_wordpress

# Start php-fpm in the foreground
echo "Starting FPM"
exec php-fpm7.4 -F
