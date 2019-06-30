start:
	@echo "Starting containers..."
	@docker-compose up -d --build

stop:
	@echo "Stopping..."
	@docker-compose down

clear:
	@docker-compose down -t 0
	@docker-compose rm -f
	@echo "Removing Kafka state dir [/tmp/kafka-streams/]"
	@rm -rf /tmp/kafka-streams/

status:
	@watch docker-compose ps

recreate: clear start

lets-go: recreate status

list-topics:
	@docker-compose exec kafka /kafka/bin/kafka-topics.sh --list \
    --bootstrap-server kafka:9092

consume-topic: # params: TOPIC_NAME
	@docker-compose exec kafka /kafka/bin/kafka-console-consumer.sh \
       --bootstrap-server kafka:9092 \
       --topic ${TOPIC_NAME} \
       --property print.key=true \
       --property key.separator="  #### ->   " \
       --from-beginning

open-mysql:
	@docker-compose exec mysql bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD inventory'

open-ksql:
	@docker-compose exec ksql-cli ksql http://ksql-server:8088

listen-connectors:
	@watch -n .5 curl -H "Accept:application/json" localhost:8083/connectors/
