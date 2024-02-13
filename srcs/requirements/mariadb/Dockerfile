# use penultimate version of debian as the base image
FROM	debian:bullseye

# Expose MariaDB default port
EXPOSE	3306

# install MariaDB (and remove apt package lists to reduce image size)
RUN		apt-get update && apt-get install -y \
		mariadb-server \
		iputils-ping \
		netcat \
		gettext \
		tini && \
		apt-get clean && rm -rf /var/lib/apt/lists/*

# copy mariadb script to /bin/ on container filesystem
COPY	tools/start-mariadb.sh /bin/
# set permissions so that start-mariadb.sh is executable
RUN		chmod +x /bin/start-mariadb.sh && \
		chown -R mysql:mysql /var/log/mysql && \
		chmod -R 755 /var/log/mysql

# Copy SQL initialization script into the image
COPY	./tools/secure_mariadb.sql /secure_mariadb.sql
# set permissions
RUN		chmod 644 /secure_mariadb.sql

# Use tini as the entrypoint
# ENTRYPOINT ["tini", "--"]

# Start MariaDB with the init file
CMD		["start-mariadb.sh"]