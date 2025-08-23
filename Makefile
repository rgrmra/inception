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

VOLUMES				:= mariadb wordpress static_site

VOLUMES_DIRECTORY	:= $(VOLUMES:%=/home/$(LOCAL_USER)/data/%)

all:
	#@if $(DOCKER_COMPOSE) up --dry-run 2>&1 | grep -E 'Built|Created' $(QUIET); \
	#then \
		mkdir -p $(VOLUMES_DIRECTORY); \
		make build --no-print-directory; \
		make up --no-print-directory; \
	#fi

up:
	@BUILDKIT=1 $(DOCKER_COMPOSE) up -d $(SERVICE)

stop:
	@$(DOCKER_COMPOSE) stop $(SERVICE)

start:
	@$(DOCKER_COMPOSE) start $(SERVICE)

restart:
	@$(DOCKER_COMPOSE) restart $(SERVICE)

down:
	@$(DOCKER_COMPOSE) down $(SERVICE)

logs:
	@$(DOCKER_COMPOSE) logs --follow $(SERVICE)

build:
	@$(DOCKER_COMPOSE) build #--no-cache $(SERVICE)

ps:
	@$(DOCKER_COMPOSE) ps --all

shell-%:
	@if docker ps | grep -w ${COMPOSE_PROJECT_NAME}-$* $(QUIET); \
	then \
		docker exec -it ${COMPOSE_PROJECT_NAME}_$* $(DOCKER_SHELL); \
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
