DOCKER_SHELL		:= /bin/ash

PROJECT_DIRECTORY	:= ./srcs

ifeq ($(shell find $(PROJECT_DIRECTORY) -name '.env' 2> /dev/null),)
  $(error .env missing at $(PROJECT_DIRECTORY))
else
  include $(PROJECT_DIRECTORY)/.env
endif

QUIET				:= > /dev/null 2>&1

DOCKER_COMPOSE		:= $(shell \
	if docker compose version $(QUIET); \
		then \
		echo 'docker compose'; \
	elif docker-compose version $(QUIET); \
		then \
		echo 'docker-compose'; \
	fi) --project-directory $(PROJECT_DIRECTORY)

VOLUMES				:= mariadb \
					   wordpress

VOLUMES_DIRECTORY	:= $(VOLUMES:%=/home/$(LOCAL_USER)/data/%)

SERVICES			:= mariadb \
					   wordpress \
					   nginx \
					   redis \
					   adminer \
					   vsftpd \
					   static_site \
					   cadvisor

REQUIRED_ENVS				:= COMPOSE_PROJECT_NAME \
					   LOCAL_USER \
					   SHARED_GROUP \
					   MARIADB_HOST \
					   MARIADB_PORT \
					   MARIADB_DATABASE \
					   MARIADB_USER \
					   WORDPRESS_HOST \
					   WORDPRESS_PORT \
					   WORDPRESS_DOMAIN \
					   WORDPRESS_USER \
					   WORDPRESS_USER_EMAIL \
					   WORDPRESS_ROOT \
					   WORDPRESS_ROOT_EMAIL \
					   NGINX_HOST \
					   NGINX_PORT \
					   REDIS_HOST \
					   REDIS_PORT \
					   VSFTPD_HOST \
					   VSFTPD_PORT \
					   VSFTPD_PORT_RANGE \
					   VSFTPD_USER \
					   STATIC_SITE_PORT \
					   ADMINER_HOST \
					   ADMINER_PORT \
					   CADVISOR_HOST \
					   CADVISOR_PORT \

ifdef SERVICE
	SERVICES 		:= $(SERVICE)
endif

all:
	@mkdir -p $(VOLUMES_DIRECTORY)
	@make up SERVICES="$(SERVICES)" --no-print-directory

up:
	@BUILDKIT=1 $(DOCKER_COMPOSE) up -d $(SERVICES)

stop:
	@$(DOCKER_COMPOSE) stop $(SERVICES)

start:
	@$(DOCKER_COMPOSE) start $(SERVICES)

restart:
	@$(DOCKER_COMPOSE) restart $(SERVICES)

down:
	@$(DOCKER_COMPOSE) down $(SERVICES)

logs:
	@$(DOCKER_COMPOSE) logs --follow $(SERVICES)

build:
	@$(DOCKER_COMPOSE) build --no-cache $(SERVICES)

ps:
	@$(DOCKER_COMPOSE) ps --all $(SERVICES)

shell-%:
	@if docker ps | grep -w $* $(QUIET); \
	then \
		docker exec -it $* $(DOCKER_SHELL); \
	else \
		echo "image 'shell-$*' not found"; \
	fi

clean:
	@if docker image ls | grep $(COMPOSE_PROJECT_NAME) $(QUIET); \
	then \
		$(DOCKER_COMPOSE) down --timeout 1 --rmi local; \
	elif docker network ls | grep $(COMPOSE_PROJECT_NAME) $(QUIET); \
	then \
		$(DOCKER_COMPOSE) down --timeout 1 --rmi local; \
	fi

fclean: clean
	@if docker volume ls | grep $(COMPOSE_PROJECT_NAME) $(QUIET); \
	then \
		$(DOCKER_COMPOSE) down --timeout 1 --volumes;\
	fi

re: fclean all

prune:
	docker system prune

.PHONY: all up stop start restart down logs build ps shell-% clean fclean re prune
