#!/bin/bash
set -e

docker-compose up -d

echo "Waiting 10 sec for containers to start"
sleep 10

echo "Seeding database with mock-data"
./scripts/seed.sh

