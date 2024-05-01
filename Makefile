.PHONY: all up down clean

DATA_PATH = /home/ouhassna/data
# Default target
all: up

# Start Docker containers
up: setup
	docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml up -d

# Stop and remove Docker containers
down:
	docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml down -v

#stop Docker containers
stop:
	docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml stop

#see containers that are running
status:
	docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml ps

#see images 
images:
	docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml images

#restat containers:
restart:
	docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml restart

clean: down
	sudo rm -rf $(DATA_PATH)

fclean:
	docker system prune -f --volumes
	docker volume rm src_wp-data srcs_db-data

setup:
	sudo mkdir -p ${DATA_PATH}
	sudo mkdir -p ${DATA_PATH}/mariadb-data
	sudo mkdir -p ${DATA_PATH}/wordpress-data


