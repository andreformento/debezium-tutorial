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
