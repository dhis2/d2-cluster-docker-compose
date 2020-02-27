#!/bin/bash
set -e


[[ -z "$DOCKER_COMPOSE" ]] && DOCKER_COMPOSE="docker-compose"

$DOCKER_COMPOSE run core yarn db:reset


