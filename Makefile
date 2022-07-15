.ONESHELL:


SERVICES:=
# options: dev, prod

DOCKER=docker-compose \
	--env-file .env \
	--project-name poc \
	--file docker/docker-compose.yaml

# PREPARE ENVIRONMENT
.PHONY:prepare-env
prepare-env:
	SHELL := /usr/bin/sh
	source env.sh
	envsubst < env.tpl > .env

# docker-compose up airflow-init

# DOCKER

.PHONY:docker-build
docker-build:
	$(DOCKER) build ${SERVICES}

.PHONY:docker-start
docker-start:
	$(DOCKER) up -d ${SERVICES}

.PHONY:docker-postgres-db
docker-postgres-db:
	$(DOCKER) up -d postgres

.PHONY:docker-init-db
docker-init-db: docker-postgres-db
	$(DOCKER) up -d initdb

.PHONY:docker-start-ci
docker-start-ci: postgres
	$(DOCKER) up -d --scale base=0

.PHONY:docker-stop
docker-stop:
	$(DOCKER) stop ${SERVICES}

.PHONY:docker-restart
docker-restart: docker-stop docker-start
	echo "[II] Docker services restarted!"

.PHONY:docker-exec
docker-exec:
	$(DOCKER) exec ${SERVICES} bash


.PHONY:docker-logs-follow
docker-logs-follow:
	$(DOCKER) logs --follow --tail 300 

.PHONY:remove-orphans
remove-orphans:
	$(DOCKER) down --volumes --remove-orphans