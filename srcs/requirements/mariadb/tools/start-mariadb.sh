#!/bin/bash

echo "mysqld_safe starting..."

# Start MariaDB
exec mysqld_safe
# Import all .cnf files from configuration directory
# !includedir /etc/mysql/conf.d/
# !includedir /etc/mysql/mariadb.conf.d/