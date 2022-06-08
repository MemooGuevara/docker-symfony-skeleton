#!/bin/bash


DOCKER_APP = example-app
DOCKER_NETWORK = example-network

OS := $(shell uname)
ifeq ($(OS),Darwin)
	UID = $(shell id -u)
else ifeq ($(OS),Linux)
	UID = $(shell id -u)
else
	UID = 1000
endif



help: ## Show this help message
	@echo 'usage: make [target]'
	@echo
	@echo 'targets:'
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

start: ## Start the containers
	docker network create ${DOCKER_NETWORK} || true
	cp -n docker-compose.yml.dist docker-compose.yml || true
	U_ID=${UID} docker-compose up -d

stop: ## Stop the containers
	U_ID=${UID} docker-compose stop

restart: ## Restart the containers
	$(MAKE) stop && $(MAKE) start

build: ## Rebuilds all the containers
	docker network create ${DOCKER_NETWORK} || true
	cp -n docker-compose.yml.dist docker-compose.yml || true
	U_ID=${UID} docker-compose build

prepare: ## Runs app commands
	$(MAKE) composer-install

run: ## Starts the Symfony development server in detached mode
	U_ID=${UID} docker exec -it --user ${UID} ${DOCKER_APP} symfony serve -d

logs: ## Show Symfony logs in real time
	U_ID=${UID} docker exec -it --user ${UID} ${DOCKER_APP} symfony server:log

# App commands
composer-install: ## Installs composer dependencies 
	U_ID=${UID} docker exec --user ${UID} -it ${DOCKER_APP} composer install
# End app commands

ssh-app: ## bash into the container
	U_ID=${UID} docker exec -it --user ${UID} ${DOCKER_APP} bash

code-style: ## Runs php-cs to fix code styling following Symfony rules
	U_ID=${UID} docker exec --user ${UID} ${DOCKER_APP} php-cs-fixer fix src --rules=@Symfony
