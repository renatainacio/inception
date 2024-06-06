all:
	sudo grep -q rinacio /etc/hosts || sudo sed -i "3i127.0.0.1\trinacio.42.fr" /etc/hosts
	docker compose -f ./srcs/docker-compose.yml up -d --build

up:
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down

stop:
	docker compose -f ./srcs/docker-compose.yml stop

fclean: down
	docker stop $$(docker ps -qa); \
	docker rm $$(docker ps -qa); \
	docker rmi -f $$(docker images -qa); \
	docker volume rm $$(docker volume ls -q); \
	docker network rm $$(docker network ls -q);\

re:
	clean all

.PHONY: all re down clean