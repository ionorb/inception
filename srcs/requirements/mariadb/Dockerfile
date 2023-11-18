# use penultimate version of debian as the base image
FROM	debian:bullseye

# Expose MariaDB default port
EXPOSE	3306

# install MariaDB (and remove apt package lists to reduce image size)
RUN		apt-get update && apt-get install -y \
		mariadb-server \
		tini && \
		apt-get clean && rm -rf /var/lib/apt/lists/* 

# COPY	conf/my.cnf /etc/mysql/mariadb.conf.d/

# copy mariadb script to /bin/ on container filesystem
COPY	tools/mariadb-script.sh /bin/
# set permissions so that mariadb-script.sh is executable
RUN		chmod +x /bin/mariadb-script.sh

# run script as main process
CMD		["mariadb-script.sh", "mysqld_safe"]