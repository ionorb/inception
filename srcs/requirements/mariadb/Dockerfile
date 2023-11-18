# use penultimate version of debian as the base image
FROM	debian:bullseye

# Expose MariaDB default port
EXPOSE	3306

# install MariaDB (and remove apt package lists to reduce image size)
RUN		apt-get update && apt-get install -y \
		mariadb-server \
		tini && \
		apt-get clean && rm -rf /var/lib/apt/lists/*

# copy mariadb script to /bin/ on container filesystem
COPY	tools/start-mariadb.sh /bin/
# set permissions so that start-mariadb.sh is executable
RUN		chmod +x /bin/start-mariadb.sh

# run tini as entrypoint to set as PID 1 and reap zombies
ENTRYPOINT ["tini", "--"]
# run script as main process
CMD		["start-mariadb.sh"]