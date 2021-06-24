#!/bin/bash
cd $(git rev-parse --show-toplevel)
set -ex

docker-compose build
docker-compose up -d

# Wait for connect to get up
for ((i=0;i<=30;i++));
do
  sleep 10;
  docker exec connect curl "http://localhost:8083/connectors" && break;
  if [ $i == 30 ]; then
    echo "Could not connect to connectors"
    exit
  fi
done

source ./bin/set_ambient.sh

pytest