#!/bin/bash

# set -x

echo "Starting MariaDB server..."

# Start the MariaDB server in the background
mysqld_safe &
mariadb_pid=$!

echo "Waiting for MariaDB server to start..."
while ! mysqladmin ping --silent; do
	sleep 2
done

echo "MariaDB server started. Setting up user: ${MYSQL_USER}"
run_cmd="mysql -u root -p${MYSQL_ROOT_PASSWORD} -e"

# Create database
echo "Create db if it doesn't exist"
$run_cmd "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"

# Create user
echo "Create user if it doesn't exist"
$run_cmd "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

# Grant privileges
echo "Grant all privileges on ${DB_NAME} to ${MYSQL_USER}"
$run_cmd "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${MYSQL_USER}\`@'%';"

# Flush privileges
echo "Flush privileges"
$run_cmd "FLUSH PRIVILEGES;"


# CREATE DATABASE IF NOT EXISTS $DB_NAME;
# GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
# GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWORD';
# SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_ROOT_PASSWORD');

echo "Setup complete."

# Wait for the background MariaDB server to stop
wait $mariadb_pid

echo "Launching Database as the main process."

# Replace the current shell with mysqld_safe as the main process
exec mysqld_safe
