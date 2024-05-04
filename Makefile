.PHONY: all up down clean start

DATA_PATH = /home/ouhassna/data

all: up

up: setup
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

stop:
	docker-compose -f ./srcs/docker-compose.yml stop


status:
	docker-compose -f ./srcs/docker-compose.yml ps

 
images:
	docker-compose -f ./srcs/docker-compose.yml images


restart:
	docker-compose -f ./srcs/docker-compose.yml restart


clean: down
		@sudo rm -rf ${DATA_PATH}

fclean: 
		docker-compose -f ./srcs/docker-compose.yml down -v
		@if [ "$$(docker images -q | wc -l)" -gt 0 ]; then \
			docker rmi -f $$(docker images -aq); \
		fi
	 	@sudo rm -rf ${DATA_PATH}

setup:
	@if [ ! -d $(DATA_PATH) ]; then \
		mkdir -p ${DATA_PATH}; \
	fi

	@mkdir -p ${DATA_PATH}/mariadb-data
	@mkdir -p ${DATA_PATH}/wordpress-data

start: up
