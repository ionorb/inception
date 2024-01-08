COMPOSE_FILE := srcs/docker-compose.yml

all: ssl-gen build up

build:
	mkdir -p /home/yridgway/data/mariadb
	mkdir -p /home/yridgway/data/wordpress
	docker-compose -f $(COMPOSE_FILE) build

up:
	docker-compose -f $(COMPOSE_FILE) up -d

down:
	docker-compose -f $(COMPOSE_FILE) down

logs:
	docker-compose -f $(COMPOSE_FILE) logs -f

# docker image rm srcs-mariadb; docker image rm srcs-wordpress; docker image rm srcs-nginx; echo "done"
clean:
	@echo "removing containers, images, volumes, networks..."
	docker-compose -f $(COMPOSE_FILE) down -v
	-@docker stop $(docker ps -qa) > /dev/null 2>&1; docker rm $(docker ps -qa) > /dev/null 2>&1; docker rmi -f $(docker images -qa) > /dev/null 2>&1; docker volume rm $(docker volume ls -q) > /dev/null 2>&1; docker network rm $(docker network ls -q) > /dev/null 2>&1
	@echo "docker prune..."
	@yes | docker image prune > /dev/null 2>&1
	@yes | docker container prune > /dev/null 2>&1
	@yes | docker volume prune > /dev/null 2>&1
	@yes | docker network prune > /dev/null 2>&1
	@yes | docker system prune > /dev/null 2>&1
	@echo "removing data..."
	rm -rf /home/yridgway/data/wordpress
	rm -rf /home/yridgway/data/mariadb
	@echo "done"

ssl-gen:
	@if [ ! -f srcs/requirements/nginx/certs/inception.crt ] || [ ! -f srcs/requirements/nginx/certs/inception.key ]; then \
		openssl req -x509 -nodes -out srcs/requirements/nginx/certs/inception.crt -keyout srcs/requirements/nginx/certs/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=yridgway.42.fr/UID=yridgway"; \
	else \
		echo "SSL certificate and key already exist."; \
	fi

.PHONY: all build up down logs ssl-gen clean
