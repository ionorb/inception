#!/bin/bash

# set -x

echo "Starting MariaDB server..."

envsubst < secure_mariadb.sql > secure_mariadb_env.sql

# Replace the current shell with mysqld_safe as the main process
exec mysqld_safe --init-file=/secure_mariadb_env.sql
