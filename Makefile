RESET		:= $(shell tput -Txterm sgr0)
YELLOW		:= $(shell tput -Txterm setaf 3)
BLUE		:= $(shell tput -Txterm setaf 6)

NETWORK_NUM	:= $(shell docker network ls | grep -n intra | cut -f 1 -d ':')

COMPOSE_FILE	= ./srcs/docker-compose.yml

all: up

up:
ifneq ($(findstring yhwang.42.fr, $(shell cat /etc/hosts)), yhwang.42.fr)
	@echo "127.0.0.1	yhwang.42.fr" | sudo tee -a /etc/hosts
endif

	@echo "$(BLUE)Creating and starting containers..$(RESET)"

ifneq ($(shell ls /home/yhwang/data/ | grep wordpress | wc -l ), 1)
	@sudo mkdir -p /home/yhwang/data/wordpress
endif

ifneq ($(shell ls /home/yhwang/data/ | grep mysql | wc -l ), 1)
	@sudo mkdir -p /home/yhwang/data/mysql
endif

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
	@docker image ls
	@echo ""

	@echo "$(BLUE)LIST OF NETWORKS:$(RESET)"
ifneq ($(findstring intra, $(shell docker network ls)), intra)
	@docker network ls
	@echo "$(YELLOW)There is no docker-network named intra$(RESET)"
else
	@docker network ls | head -$(shell echo $(NETWORK_NUM)-1 | bc -l)
	@echo "$(YELLOW)$(shell docker network ls | grep intra)$(RESET)"
	@docker network ls | tail -$(shell echo $(shell echo $(NETWORK_NUM)\
	-$(shell echo $(NETWORK_NUM)-1 | bc -l) | bc -l))
endif

stop:
ifneq ($(shell docker ps -a | wc -l), 1)
	@echo "$(BLUE)Stopping container..$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) stop
	@echo "$(YELLOW)Containers succesfully stopped$(RESET)"
else
	@echo "$(YELLOW)There is no container to stop$(RESET)"
endif

restart:
ifneq ($(shell docker ps -a | wc -l), 1)
	@echo "$(BLUE)Restarting container..$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) restart
	@echo "$(YELLOW)Containers succesfully restarted$(RESET)"
else
	@echo "$(YELLOW)There is no container to restart$(RESET)"
endif

fclean:
	@echo "$(BLUE)Removing everything..$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) stop
	@echo "$(YELLOW)Containers succesfully stopped$(RESET)"

ifneq ($(shell echo $(shell echo $(shell docker ps -a | wc -l)-1 | bc -l)\
	+$(shell docker network ls | grep intra | wc -l)\
	+$(shell echo $(shell docker volume ls | wc -l)-1 | bc -l) | bc -l), 0)
	@docker-compose -f $(COMPOSE_FILE) down -v
	@echo "$(YELLOW)Containers successfully removed$(RESET)"
	@echo "$(YELLOW)Networks successfully removed$(RESET)"
	@echo "$(YELLOW)Volumes successfully removed$(RESET)"
else
	@echo "$(YELLOW)There is no container to remove$(RESET)"
	@echo "$(YELLOW)There is no network to remove$(RESET)"
	@echo "$(YELLOW)There is no volume to remove$(RESET)"
endif

ifneq ($(shell docker image ls | wc -l), 1)
	@docker rmi $(shell docker images -q) -f
	@echo "$(YELLOW)Images succesfully removed$(RESET)"
else
	@echo "$(YELLOW)There is no image to remove$(RESET)"
endif

ifeq ($(shell ls /home/yhwang/data/ | grep wordpress | wc -l ), 1)
	@sudo rm -rf /home/yhwang/data/wordpress
endif

ifeq ($(shell ls /home/yhwang/data/ | grep mysql | wc -l ), 1)
	@sudo rm -rf /home/yhwang/data/mysql
endif

	@echo "$(BLUE)Everything is successfully removed!$(RESET)"

.PHONY: all up list stop fclean
