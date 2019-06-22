# debezium-tutorial
Just an example of debezium tutorial with MySQL

## Using Docker Compose
- Start all
```shell
make lets-go
```
- List topics
```shell
make list-topics
```
- Consume messages from a Debezium topic
```shell
make consume-topic TOPIC_NAME=dbserver1.inventory.addresses
```

- Stop and clear all
```shell
make clear
```

[Reference](https://github.com/debezium/debezium-examples/blob/master/tutorial/README.md)


## Using just Docker

- Start Zookeeper
```shell
docker run -it --rm --name zookeeper -p 2181:2181 -p 2888:2888 -p 3888:3888 debezium/zookeeper:0.9.5.Final
```

- Start Kafka
```shell
docker run -it --rm --name kafka -p 9092:9092 --link zookeeper:zookeeper debezium/kafka:0.9.5.Final
```
- MySQL
  - Build 
```shell
docker build -t andreformento/debezium-mysql:0.9.5.Final mysql-image/
```
  - Start `docker run -it --rm --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=debezium -e MYSQL_USER=mysqluser -e MYSQL_PASSWORD=mysqlpw andreformento/debezium-mysql:0.9.5.Final`
  - Connect `docker exec -it mysql mysql -u mysqluser -pmysqlpw --database inventory`

- Kafka connect
```shell
docker run -it --rm --name connect -p 8083:8083 -e GROUP_ID=1 -e CONFIG_STORAGE_TOPIC=my_connect_configs -e OFFSET_STORAGE_TOPIC=my_connect_offsets -e STATUS_STORAGE_TOPIC=my_connect_statuses --link zookeeper:zookeeper --link kafka:kafka --link mysql:mysql debezium/connect:0.9.5.Final
```

- Monitor the MySQL database
```shell
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors/ -d '{ "name": "inventory-connector", "config": { "connector.class": "io.debezium.connector.mysql.MySqlConnector", "tasks.max": "1", "database.hostname": "mysql", "database.port": "3306", "database.user": "debezium", "database.password": "dbz", "database.server.id": "184054", "database.server.name": "dbserver1", "database.whitelist": "inventory", "database.history.kafka.bootstrap.servers": "kafka:9092", "database.history.kafka.topic": "dbhistory.inventory" } }'
```
- Clean up
```shell
docker stop mysqlterm watcher connect mysql kafka zookeeper
```

[Reference](https://debezium.io/docs/tutorial)

### Anothers examples

- https://debezium.io/blog/tags/example/
- https://debezium.io/blog/2018/05/24/querying-debezium-change-data-eEvents-with-ksql/
