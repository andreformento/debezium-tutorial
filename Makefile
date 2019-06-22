start:
	@echo "Starting containers..."
	@docker-compose up -d --build

stop:
	@echo "Stopping..."
	@docker-compose down

clear:
	@docker-compose rm -f -s
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
