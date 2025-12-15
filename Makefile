up:
	@mkdir -p /home/locharve/data/mariadb
	@mkdir -p /home/locharve/data/wordpress
	docker compose --project-directory srcs up
up-build:
	@mkdir -p /home/locharve/data/mariadb
	@mkdir -p /home/locharve/data/wordpress
	docker compose --project-directory srcs up --build
up-detach:
	@mkdir -p /home/locharve/data/mariadb
	@mkdir -p /home/locharve/data/wordpress
	docker compose --project-directory srcs up -d
	@echo "Inception is ready to use."
up-build-detach:
	@mkdir -p /home/locharve/data/mariadb
	@mkdir -p /home/locharve/data/wordpress
	docker compose --project-directory srcs up --build -d
	@echo "Inception is ready to use."
up-detach-build: up-build-detach
udb: up-detach-build
ubd: udb
ub: up-build
ud: up-detach

show-volumes:
	docker volume ls
show-containers:
	docker ps
show-images:
	docker images
show-network:
	docker network ls
show-all: show-volumes show-containers show-images show-network
show: show-all

clean:
	@echo "Stopping running containers..."
	$(eval RUNNING_DOCKERS=`docker ps -qa`)
	@-docker stop $(RUNNING_DOCKERS) > /dev/null 2>&1

	@echo "Removing containers..."
	$(eval BUILT_CONTAINERS=`docker ps -qa`)
	@-docker rm $(BUILT_CONTAINERS) > /dev/null 2>&1

	@echo "Removing images..."
	$(eval DOCKER_IMAGES=`docker images -qa`)
	@-docker rmi -f $(DOCKER_IMAGES) > /dev/null 2>&1

	@echo "Removing volumes..."
	$(eval DOCKER_VOLUMES=`docker volume ls -q`)
	@-docker volume rm $(DOCKER_VOLUMES) > /dev/null 2>&1

	@echo "Removing networks..."
	$(eval DOCKER_NETWORKS=`docker network ls -q`)
	@-docker network rm $(DOCKER_NETWORKS) > /dev/null 2>&1

fclean: clean
	@echo "Pruning..."
	@docker system prune -af

re: clean up
fre: fclean up

down:
	docker compose --project-directory srcs down

.PHONY: up up-build up-detach up-build-detach up-detach-build udb ubd \
	show-volumes show-containers show-images show-network show-all show \
	clean down ub ud
