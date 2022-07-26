.ONESHELL:


SERVICES:=

DOCKER=docker-compose \
	--env-file .env \
	--project-name poc \
	--file docker/docker-compose.yaml

# DOCKER

.PHONY:docker-build
docker-build:
	$(DOCKER) build ${SERVICES}

.PHONY:docker-start
docker-start:
	$(DOCKER) up -d postgres
	./docker/healthcheck.sh postgres
	$(DOCKER) up airflow-initdb
	$(DOCKER) up -d airflow airflow-scheduler

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
