COMPOSE_FILE := srcs/docker-compose.yml

all: ssl-gen build up

build:
	mkdir -p ~/data
	mkdir -p ~/data/mariadb
	mkdir -p ~/data/wordpress
	docker compose -f $(COMPOSE_FILE) build

up:
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

ssl-gen:
	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=yridgway.42.fr/UID=yridgway"

.PHONY: all build up down logs ssl-gen