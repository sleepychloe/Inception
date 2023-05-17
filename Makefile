COMPOSE_FILE = ./srcs/docker-compose.yml

all: build

build:
	@echo "Building.."
	@sudo mkdir -p /home/yhwang/data/wordpress
	@sudo mkdir -p /home/yhwang/data/mysql
	@docker-compose -f $(COMPOSE_FILE) up --build -d

list:
	@echo "LIST OF CONTAINERS:"
	docker ps -a
	@echo "LJIST OF VOLUMES:"
	docker volume ls

down:
	@echo "Stopping.."
	@docker-compose -f $(COMPOSE_FILE) down

clean:
	@echo "Removing everything.."
	@docker-compose -f $(COMPOSE_FILE) down
	@docker system prune --all --force --volumes

	@-docker volume rm `docker volume ls -q`

	@docker network prune --force
	
	@sudo rm -rf /home/yhwang/data/wordpress
	@sudo rm -rf /home/yhwang/data/mysql
	@echo "DONE!"

.PHONY: all build list down clean