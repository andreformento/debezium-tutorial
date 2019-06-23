# debezium-tutorial
Just an example of debezium tutorial with MySQL

## Start all applications with docker-compose
- Start all `make lets-go`
  - List topics `make list-topics`
  - Consume messages from a Debezium topic `make consume-topic TOPIC_NAME=dbserver1.inventory.addresses`
  - Go to MySQL cli `make open-mysql`
  - Go to KSQL cli `make open-ksql`
- Stop and clear all `make clear`

## Join events
- Open cli `make open-ksql`
- List topics `LIST TOPICS;`

KSQL processing by default starts with latest offsets. We want to process the events already in the topics so we switch processing from earliest offsets.

- Configure offset `SET 'auto.offset.reset' = 'earliest';`
- Create base streams
```sql
CREATE STREAM orders_from_debezium (order_number integer, order_date string, purchaser integer, quantity integer, product_id integer) \
    WITH (KAFKA_TOPIC='dbserver1.inventory.orders',VALUE_FORMAT='json');

CREATE STREAM customers_from_debezium (id integer, first_name string, last_name string, email string) \
    WITH (KAFKA_TOPIC='dbserver1.inventory.customers',VALUE_FORMAT='json');

CREATE STREAM orders WITH (KAFKA_TOPIC='ORDERS_REPART',VALUE_FORMAT='json',PARTITIONS=1) \
    as SELECT * FROM orders_from_debezium PARTITION BY PURCHASER;

CREATE STREAM customers_stream WITH (KAFKA_TOPIC='CUSTOMERS_REPART',VALUE_FORMAT='json',PARTITIONS=1) \
    as SELECT * FROM customers_from_debezium PARTITION BY ID;

CREATE TABLE customers (id integer, first_name string, last_name string, email string) \
    WITH (KAFKA_TOPIC='CUSTOMERS_REPART',VALUE_FORMAT='json',KEY='id');
```
- Show first `SELECT * FROM orders_from_debezium LIMIT 1;`
- Create join
```sql
CREATE STREAM customers_orders_stream WITH (KAFKA_TOPIC='CUSTOMERS_ORDERS_REPART',VALUE_FORMAT='json',PARTITIONS=1) \
    as SELECT order_number,quantity,customers.first_name,customers.last_name \
  FROM orders \
       left join customers on orders.purchaser=customers.id;

SELECT * FROM customers_orders_stream;
```
- Open a new terminal, go to MySQL `make open-mysql` and change values
```sql
INSERT INTO orders VALUES(default,NOW(), 1003,5,101);
UPDATE customers SET first_name='Annie' WHERE id=1004;
UPDATE orders SET quantity=20 WHERE order_number=10004;
```

## References

- https://debezium.io/docs/tutorial
- https://debezium.io/blog/tags/example/
- https://debezium.io/blog/2018/05/24/querying-debezium-change-data-eEvents-with-ksql/
- https://github.com/debezium/debezium-examples/blob/master/tutorial/README.md
