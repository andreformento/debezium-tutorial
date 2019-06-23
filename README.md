# debezium-tutorial
Just an example of debezium tutorial with MySQL

## Start all applications with docker-compose
- Start all `make lets-go`
  - List topics `make list-topics`
  - Consume messages from a Debezium topic `make consume-topic TOPIC_NAME=dbserver1.inventory.addresses`
  - Go to MySQL cli `make open-mysql`
- Stop and clear all `make clear`

## Join events
- Open cli `docker-compose exec ksql-cli ksql http://ksql-server:8088`
- List topics `LIST TOPICS;`
KSQL processing by default starts with latest offsets. We want to process the events already in the topics so we switch processing from earliest offsets.
- Configure offset `SET 'auto.offset.reset' = 'earliest';`
- Create streams
```shell
CREATE STREAM orders_from_debezium (order_number integer, order_date string, purchaser integer, quantity integer, product_id integer) WITH (KAFKA_TOPIC='dbserver1.inventory.orders',VALUE_FORMAT='json');
CREATE STREAM customers_from_debezium (id integer, first_name string, last_name string, email string) WITH (KAFKA_TOPIC='dbserver1.inventory.customers',VALUE_FORMAT='json');
CREATE STREAM orders WITH (KAFKA_TOPIC='ORDERS_REPART',VALUE_FORMAT='json',PARTITIONS=1) as SELECT * FROM orders_from_debezium PARTITION BY PURCHASER;
CREATE STREAM customers_stream WITH (KAFKA_TOPIC='CUSTOMERS_REPART',VALUE_FORMAT='json',PARTITIONS=1) as SELECT * FROM customers_from_debezium PARTITION BY ID;
```
- Select `SELECT * FROM orders_from_debezium LIMIT 1;`

## References

- https://debezium.io/docs/tutorial
- https://debezium.io/blog/tags/example/
- https://debezium.io/blog/2018/05/24/querying-debezium-change-data-eEvents-with-ksql/
- https://github.com/debezium/debezium-examples/blob/master/tutorial/README.md
