.PHONY: build run
build:
	-docker volume create local-devel
	docker build ./ -t archlinux:local-devel
run: build
	-mkdir ${HOME}/workplace/
	if [ $$(docker ps -q -f name=local-devel) ]; then \
		echo "Container local-devel is running. Attaching..."; \
		docker exec -it local-devel /bin/zsh; \
	elif [ $$(docker ps -aq -f status=exited -f name=local-devel) ]; then \
		echo "Container local-devel exists but stopped. Starting and attaching..."; \
		docker start local-devel; \
		docker attach local-devel; \
	else \
		echo "Container does not exist. Running..."; \
		docker run --name local-devel --network=host -h local-devel -v ${HOME}/workplace/:/home/arch/workplace -v local-devel:/home/arch -v "//var/run/docker.sock://var/run/docker.sock" -v ${HOME}:/home/arch/host/ -it archlinux:local-devel; \
	fi
remove:
	-docker ps -a -q --filter "name=local-devel" | xargs -r docker rm
restart: remove run	
clean: remove 
	-docker rmi archlinux:local-devel
	docker builder prune -f
rebuild: clean build
prompt:
	@read -p "WARNING: This will remove any files you have created in the Docker volume which are not synced to your host. Continue? [y/N]: " CONTINUE; \
				if [ "$$CONTINUE" != "y" ] && [ "$$CONTINUE" != "Y" ]; then \
						echo "Exiting"; \
								exit 1; \
									fi
prune: prompt clean
	-docker volume rm local-devel
