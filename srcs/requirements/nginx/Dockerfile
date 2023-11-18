# use penultimate version of debian as the base image
FROM	debian:bullseye

# install NGINX, openssl and tini (and remove apt package lists to reduce image size)
RUN		apt-get update && apt-get install -y \
		nginx \
		vim \
		curl \
		openssl \
		tini && \
		apt-get clean && rm -rf /var/lib/apt/lists/* 

# create directory to store ssl certificates
RUN		mkdir -p /etc/nginx/certs

# change the ownership and permissions of the html directory for the nginx user (www-data)
RUN		chmod 755 /var/www/html
RUN		chown -R www-data:www-data /var/www/html

# run nginx as main process
CMD		["nginx", "-g", "daemon off;"]