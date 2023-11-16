#!/bin/bash
# curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz

# tar -xf vscode_cli.tar.gz

mkdir -p srcs/requirements/tools
mkdir -p srcs/requirements/{mariadb,nginx,wordpress}/{conf,tools}

touch Makefile
touch srcs/{docker-compose.yml,.env}

touch srcs/requirements/{mariadb,nginx,wordpress}/{Dockerfile,.dockerignore}
touch srcs/requirements/mariadb/conf/my.cnf
touch srcs/requirements/nginx/conf/nginx.conf
touch srcs/requirements/wordpress/conf/wp-config.php