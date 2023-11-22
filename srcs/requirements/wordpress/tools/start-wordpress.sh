#!/bin/bash

# Function to check if MariaDB is ready
wait_for_db() {
    until mysqladmin ping -h"mariadb" --silent; do
        echo "($?)" "Waiting for MariaDB..."
        sleep 2
    done
}

# Function to check if wordpress is installed
check_for_wordpress() {
	if ! $(wp core is-installed --path="$WP_PATH"); then
		# Install WordPress
		wp --allow-root core install --url="example.com" --title="Example" --admin_user="uniqueuser" --admin_password="password" --admin_email="admin@example.com" --path="$WP_PATH"
		# Create a second user
		wp --allow-root user create user2 user2@example.com --role=author --user_pass=password --path="$WP_PATH"
	fi
}

# Wait for MariaDB to be ready
wait_for_db

# Path to WordPress
WP_PATH="/var/www/html"

# Check if WordPress is installed
check_for_wordpress


# Start php-fpm in the foreground
echo "Starting FPM"
exec php-fpm7.4 -F
