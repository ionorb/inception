# use penultimate version of debian as the base image
FROM	debian:bullseye

# Expose php-fpm default port
EXPOSE	9000

# Create the directory for the php-fpm socket and enable php start
RUN		mkdir -p /var/www/html/ && \
		mkdir -p /run/php && \
		chmod -R 755 /var/www/html/

# Update & Install necessary packages
RUN		apt-get update && apt-get install -y \
		php7.4 \
		php7.4-fpm \
		php7.4-cgi \
		php7.4-common \
		php7.4-mysql \
		php7.4-gd \
		php7.4-xml \
		php7.4-mbstring \
		wget \
		unzip \
		default-mysql-server \
		mariadb-client

# Download and extract WordPress
RUN		wget https://wordpress.org/latest.tar.gz && \
		tar -xvzf latest.tar.gz && \
		mv wordpress/* /var/www/html/ && \
		rmdir wordpress && \
		rm latest.tar.gz

# Install wordpress command line interface (wp-cli)
RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp

# Copy the php-fpm config file in the html directory
COPY	./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# give the nginx user (www-data) the necessary permissions
# ...to read and execute files within the web root directory
RUN		chown -R www-data:www-data /var/www/* \
		&& chmod -R 755 /var/www/*

# copy wordpress script to /bin/ on container filesystem
COPY	./tools/wp-script.sh  /bin/
# set permissions so that mariadb-script.sh is executable
RUN		chmod +x /bin/wp-script.sh

# Set the working directory
#WORKDIR /var/www/html/

# run script as main process
CMD ["wp-script.sh"]