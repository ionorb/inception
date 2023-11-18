#!/bin/bash

# Function to check if MariaDB is ready
wait_for_db() {
    until mysqladmin ping -h"mariadb" --silent; do
        echo "Waiting for MariaDB..."
        sleep 2
    done
}

# Wait for MariaDB to be ready
wait_for_db

# Start php-fpm in the foreground
exec php-fpm7.4 -F
