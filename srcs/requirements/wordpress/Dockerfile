# use penultimate version of debian as the base image
FROM	debian:bullseye

# Expose php-fpm default port
EXPOSE	9000

# Update & Install necessary packages (and remove apt package lists to reduce image size)
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
		mariadb-client \
		tini && \
		apt-get clean && rm -rf /var/lib/apt/lists/*

# Create directories for the php-fpm and server
# give the nginx user (www-data) the ownership and permissions
# ...to read and execute files within the web directory
RUN		mkdir -p /var/www/html/ && \
		mkdir -p /run/php && \
		chown -R www-data:www-data /var/www/* \
		&& chmod -R 755 /var/www/*

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

# copy wordpress script to /bin/ on container filesystem
COPY	./tools/start-wordpress.sh  /bin/
# set permissions so that start-wordpress.sh is executable
RUN		chmod +x /bin/start-wordpress.sh

# Set the working directory
#WORKDIR /var/www/html/

# run script as main process
CMD ["start-wordpress.sh"]