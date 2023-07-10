.PHONY: build run
build:
	docker build ./ -t archlinux:local-devel
run: build
	docker run -h arch -it archlinux:local-devel
clean: 
	-docker ps -a -q --filter "ancestor=archlinux:local-devel" | xargs -r docker rm
	-docker rmi archlinux:local-devel
	docker builder prune -f
rebuild: clean build run


