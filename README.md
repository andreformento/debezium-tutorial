# debezium-tutorial
Just an example of debezium tutorial with MySQL

## Start all applications with docker-compose
- Start all `make lets-go`
- List topics `make list-topics`
- Consume messages from a Debezium topic `make consume-topic TOPIC_NAME=dbserver1.inventory.addresses`
- Stop and clear all `make clear`

## Join events
- Open cli `docker-compose exec ksql-cli ksql http://ksql-server:8088`
- List topics `LIST TOPICS;`
KSQL processing by default starts with latest offsets. We want to process the events already in the topics so we switch processing from earliest offsets.
- Configure offset `SET 'auto.offset.reset' = 'earliest';`


## References

- https://debezium.io/docs/tutorial
- https://debezium.io/blog/tags/example/
- https://debezium.io/blog/2018/05/24/querying-debezium-change-data-eEvents-with-ksql/
- https://github.com/debezium/debezium-examples/blob/master/tutorial/README.md
