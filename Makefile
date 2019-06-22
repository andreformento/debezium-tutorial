start:
	@echo "Starting containers..."
	@docker-compose up -d --build

create-connector:
	@curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:8083/connectors/ -d @connector.json

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
