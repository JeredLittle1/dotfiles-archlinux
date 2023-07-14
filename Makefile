.PHONY: build run
build:
	-docker volume create local-devel
	docker build ./ -t archlinux:local-devel
run: build
	-mkdir ${HOME}/workplace/
	docker run --name local-devel -h local-devel -v ${HOME}/workplace/:/home/arch/workplace -v local-devel:/home/arch -v "//var/run/docker.sock://var/run/docker.sock" -v ${HOME}:/home/arch/host/ -it archlinux:local-devel
clean: 
	-docker ps -a -q --filter "ancestor=archlinux:local-devel" | xargs -r docker rm
	-docker rmi archlinux:local-devel
	docker builder prune -f
rebuild: clean build run
prompt:
	@read -p "WARNING: This will remove any files you have created in the Docker volume which are not synced to your host. Continue? [y/N]: " CONTINUE; \
				if [ "$$CONTINUE" != "y" ] && [ "$$CONTINUE" != "Y" ]; then \
						echo "Exiting"; \
								exit 1; \
									fi
prune: prompt clean
	-docker volume rm local-devel
attach:
	docker exec -it local-devel /bin/zsh || make run

