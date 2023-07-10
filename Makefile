.PHONY: build run
build:
	-docker volume create local-devel
	docker build ./ -t archlinux:local-devel
run: build
	docker run -h local-devel -v local-devel:/home/arch -v "//var/run/docker.sock://var/run/docker.sock" -v ${HOME}:/home/arch/host/ -it archlinux:local-devel
clean: 
	-docker ps -a -q --filter "ancestor=archlinux:local-devel" | xargs -r docker rm
	-docker rmi archlinux:local-devel
	docker builder prune -f
rebuild: clean build run
prune: clean
	-docker volume rm local-devel
	

