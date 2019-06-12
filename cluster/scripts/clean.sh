#!/bin/bash
set -e

echo "NB: Run 'seed.sh' to re-seed the database before restarting the cluster."
echo "Stopping the cluster and remove the database storage volume..."
docker-compose down --volumes
echo "DONE"