.PHONY: all up down clean start

DATA_PATH = /home/ouhassna/data

# Default target
all: up

# Start Docker containers
up: setup
	docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml up -d

# Stop and remove Docker containers
down:
	docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml down

# Stop Docker containers
stop:
	docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml stop

# See containers that are running
status:
	docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml ps

# See images 
images:
	docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml images

# Restart containers
restart:
	docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml restart

# Clean up
clean: down
		sudo rm -rf ${DATA_PATH}

# Fully clean up
fclean: 
		docker-compose -f /home/ouhassna/inception/srcs/docker-compose.yml down -v
		@if [ "$$(docker images -q | wc -l)" -gt 0 ]; then \
			docker rmi -f $$(docker images -aq); \
		fi

# Setup directories
setup:
	@if [ ! -d $(DATA_PATH) ]; then \
		mkdir -p ${DATA_PATH}; \
	fi

	@mkdir -p ${DATA_PATH}/mariadb-data
	@mkdir -p ${DATA_PATH}/wordpress-data

# Start Docker containers
start: up
