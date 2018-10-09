#!/bin/bash
set -e

if [ "$1" == "clean" ]
  then
    docker-compose build --no-cache
  else
    docker-compose build
fi