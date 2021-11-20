pip.develop:
	python3 setup.py develop
pip.install:
	pip3 install -r ./requirements.txt

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
IMAGE_TAG_VERSION=211120-1
PREFIX_DOCKER_BUILD_CLI=IMAGE_TAG_VERSION=$(IMAGE_TAG_VERSION)
DOCKER_COMPOSE_FILE_OPTION=-f $(ROOT_DIR)/deploy/docker/docker-compose.yaml
docker.build:
	$(PREFIX_DOCKER_BUILD_CLI) docker-compose $(DOCKER_COMPOSE_FILE_OPTION) build

RUN_SERVICE_NAME=main
docker.debug:
	$(PREFIX_DOCKER_BUILD_CLI) docker-compose $(DOCKER_COMPOSE_FILE_OPTION) run --rm --entrypoint=bash --service-ports $(RUN_SERVICE_NAME)

docker.up:
	$(PREFIX_DOCKER_BUILD_CLI) docker-compose $(DOCKER_COMPOSE_FILE_OPTION) up $(RUN_SERVICE_NAME)

docker.push:
	$(PREFIX_DOCKER_BUILD_CLI) docker-compose $(DOCKER_COMPOSE_FILE_OPTION) push

SERVER_PORT=8080
start: 
	uvicorn --app-dir=./src/http_test_server_py --host=0.0.0.0 --port=$(SERVER_PORT) --reload main:app 

start.deploy:
	uvicorn --app-dir=./src/http_test_server_py --host=0.0.0.0 --port=$(SERVER_PORT) main:app

