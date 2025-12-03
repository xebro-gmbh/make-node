#--------------------------
# xebro GmbH - node - 1.0.1
#--------------------------

.PHONY: node.help node.dockerignore
NODE_RUN = ${DOCKER_COMPOSE} run --rm node

NODE_DIR := $(patsubst $(XO_ROOT_DIR)/%,./%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
NODE_DIR_ABS := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

NODE := $(notdir $(patsubst %/,%,$(NODE_DIR)))

node.clean: ## remove untracked files like "node_modules" and ".npm" cache
	${NODE_RUN} rm -rf .npm/ .cache/ node_modules/

node.bash: ## Open bash inside the container
	${NODE_RUN} bash

node.build: ## run npm target "build"
	${NODE_RUN} npm run build

node.run: ## run npm target "docker"
	@${NODE_RUN} npm run $$TARGET

node.restart: ## restart docker container
	@${DOCKER_COMPOSE} restart node --no-deps

node.logs: ## show logs for node container
	@${DOCKER_COMPOSE} logs -f node

node.update: ## update all npm packages
	@${NODE_RUN} npm upgrade

node.install: ## install all environment variables and create folders
	$(call headline,"Installing node")
	$(call ensure_env_vars,".env","${NODE_DIR}.env")

node.init: ## install all npm packages
	@${NODE_RUN} npm install

node.help:
	$(call add_help, ${NODE_DIR}Makefile,${NODE})

node.gitignore:
	$(call ensure_lines,".gitignore","${NODE_DIR}.gitignore")

node.docker.build: ## Build docker container
	@${DOCKER_COMPOSE} build node --no-cache

node.docker.stop: ## Stop the node container
	@${DOCKER_COMPOSE} down node

.gitignore: node.gitignore
help: node.help
init: node.init
install: node.install node.gitignore
restart: node.restart
