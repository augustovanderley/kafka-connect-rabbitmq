#!/bin/bash

#CREATE RABBITMQ QUEUES, EXCHANGES AND BIND THEM
curl -i -u guest:guest -H "content-type:application/json" \
-XPUT -d'{"vhost":"/","durable":true}' \
http://localhost:15672/api/queues/%2f/source_queue


curl -i -u guest:guest -H "content-type:application/json" \
-XPUT -d'{"vhost":"/","durable":true}' \
http://localhost:15672/api/queues/%2f/sink_queue

curl -i -u guest:guest -H "content-type:application/json" \
-XPUT -d'{"vhost":"/","type":"direct","durable":true}' \
http://localhost:15672/api/exchanges/%2f/sink_exchange


# CREATE KAFKA TOPIC

docker exec broker kafka-topics --create --if-not-exists --zookeeper zookeeper:2181 \
--replication-factor 1 --partitions 1 \
--topic test_topic


# CREATE SOURCE AND SINK CONNECTORS

curl -X POST 'localhost:8083/connectors' \
--header 'Content-Type: application/json' \
-d @tests/rabbit_source.json

curl -X POST 'localhost:8083/connectors' \
--header 'Content-Type: application/json' \
-d @tests/rabbit_sink.json
