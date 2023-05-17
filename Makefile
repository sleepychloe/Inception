RESET		:= $(shell tput -Txterm sgr0)
YELLOW		:= $(shell tput -Txterm setaf 3)
BLUE		:= $(shell tput -Txterm setaf 6)

ETC_HOSTS	:= /etc/hosts
CONTENTS	:= $(shell cat ${ETC_HOSTS})

COMPOSE_FILE	= ./srcs/docker-compose.yml

all: up

up:
ifneq ($(findstring yhwang.42.fr,$(CONTENTS)),yhwang.42.fr)
	@echo "127.0.0.1	yhwang.42.fr" | sudo tee -a /etc/hosts
endif

	@echo "$(BLUE)Creating and starting containers..$(RESET)"
	@sudo mkdir -p /home/yhwang/data/wordpress
	@sudo mkdir -p /home/yhwang/data/mysql
	@docker-compose -f $(COMPOSE_FILE) up --build -d
	@echo "$(YELLOW)Containers succesfully created and started$(RESET)"

list:
	@echo "$(BLUE)LIST OF CONTAINERS:$(RESET)"
	@docker ps -a
	@echo ""

	@echo "$(BLUE)LIST OF VOLUMES:$(RESET)"
	@docker volume ls
	@echo ""

	@echo "$(BLUE)LIST OF IMAGES:$(RESET)"
	@docker image ls -a
	@echo ""

	@echo "$(BLUE)LIST OF NETWORKS:$(RESET)"
	@docker network ls

stop:
	@echo "$(BLUE)Stopping container..$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) stop
	@echo "$(YELLOW)Containers succesfully stopped$(RESET)"

fclean:
	@echo "$(BLUE)Removing everything..$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) stop
	@echo "$(YELLOW)Containers succesfully stopped$(RESET)"

	@docker-compose -f $(COMPOSE_FILE) down
	@echo "$(YELLOW)Containers and networks successfully removed$(RESET)"

	@docker image rm -f `docker images -qa`
	@echo "$(YELLOW)Images succesfully removed$(RESET)"

	@docker volume rm `docker volume ls -q`
	@echo "$(YELLOW)Volumes sussessfully removed$(RESET)"

	@sudo rm -rf /home/yhwang/data/wordpress
	@sudo rm -rf /home/yhwang/data/mysql
	@echo "$(BLUE)Everything is successfully removed!$(RESET)"

.PHONY: all up list stop fclean
