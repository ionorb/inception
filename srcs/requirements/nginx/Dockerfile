# use penultimate version of debian as the base image
FROM debian:bullseye

# install NGINX and dependencies
RUN apt-get update -y && \
apt-get install -y nginx vim curl && \
mkdir -p /etc/nginx/ssl && \
apt-get install -y openssl && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

# create directory to store ssl certificates
RUN mkdir -p /etc/nginx/certs

# change the ownership of the html directory
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]