.PHONY: up-tracing up-metrics up-logs up-database up-app

ENV_FILE ?= docker/environment/.env

up-tracing:
	docker-compose -f docker/tracing/docker-compose.yml up

up-metrics:
	mkdir -p docker/metrics/data
	chmod -R 777 docker/metrics/data
	docker-compose -f docker/metrics/docker-compose.yml up

up-logs:
	mkdir -p docker/logs/data
	touch docker/logs/data/log.txt
	touch docker/logs/data/offsets.yaml
	chmod -R 777 docker/logs/data
	docker-compose -f docker/logs/docker-compose.yml up

up-database:
	docker-compose -f docker/database/docker-compose.yml --env-file=${ENV_FILE} up

up-redis:
	docker-compose -f docker/redis/docker-compose.yml --env-file=${ENV_FILE} up

up-kafka:
	docker-compose -f docker/kafka/docker-compose.yml --env-file=${ENV_FILE} up

up-vault:
	docker-compose -f docker/vault/docker-compose.yml --env-file=${ENV_FILE} up

up-app:
	docker-compose -f docker/app/docker-compose.yml --env-file=${ENV_FILE} up --build
