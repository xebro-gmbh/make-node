#--------------------------
# xebro GmbH - node - 0.0.1
#--------------------------

.PHONY: node.help node.docker-ignore


node.clean: ## remove untracked files like "node_modules" and ".npm" cache
	rm -rf .npm/
	rm -rf .cache/
	rm -rf node_modules

node.docker-build: ## Build node container
	@${DOCKER_COMPOSE} ${DOCKER_FILES} build node


node.bash: ## Open bash inside the container
	@${DOCKER_COMPOSE} ${DOCKER_FILES} run --rm node bash

node.build: ## run npm target "build"
	@${DOCKER_COMPOSE} ${DOCKER_FILES} run --rm node npm run build

node.run: ## run npm target "docker"
	@${DOCKER_COMPOSE} ${DOCKER_FILES} run --rm node npm run $TARGET

node.stop: ## stop docker container
	@${DOCKER_COMPOSE} ${DOCKER_FILES} stop node

node.logs: ## show logs for node container
	@${DOCKER_COMPOSE} ${DOCKER_FILES} logs -f node

node.update: ## update all npm packages
	@${DOCKER_COMPOSE} ${DOCKER_FILES} run --rm node npm upgrade

node.install: ## install all environment variables and create folders
	$(call headline,"Installing node")
	$(call add_config,".env","docker/node/.env")
	@mkdir -p public/

node.init: ## install all npm packages
	@${DOCKER_COMPOSE} ${DOCKER_FILES} run --rm node npm install

node.help:
	$(call add_help, ./docker/node/Makefile,"node")

node.dockerignore:
	@touch .dockerignore
	$(call add_config,".dockerignore","docker/node/.dockerignore")

node.gitignore:
	$(call add_config,".gitignore","docker/node/.gitignore")

help: node.help

.dockerignore: node.dockerignore
.gitignore: node.gitignore
install: node.install node.docker-ignore node.gitignore node.docker-build
