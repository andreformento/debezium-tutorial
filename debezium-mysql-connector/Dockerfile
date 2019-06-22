FROM debezium/kafka:0.9.5.Final
LABEL maintainer "André Formento <andreformento.sc@gmail.com>"

# Environments
#ENV KAFKA_HOME=/opt/kafka
ENV PLUGINS_DIR=$KAFKA_HOME/plugins
#ENV CONFIGS_DIR=/opt/configs
ENV CONFIGS_DIR=/kafka/config

#ENV KAFKA_CONNECT_PLUGINS_DIR=$KAFKA_HOME/connect

RUN echo $KAFKA_HOME

USER root

RUN mkdir -p $CONFIGS_DIR \
 && mkdir -p $PLUGINS_DIR

WORKDIR $KAFKA_HOME

# Debezium mysql connector
RUN curl --output /tmp/dbz-mysql.tar.gz \
	http://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/0.9.5.Final/debezium-connector-mysql-0.9.5.Final-plugin.tar.gz \
	&& tar -xzvf /tmp/dbz-mysql.tar.gz -C $PLUGINS_DIR \
	&& rm -f /tmp/dbz-mysql.tar.gz

VOLUME $CONFIGS_DIR

ENTRYPOINT ["/docker-entrypoint.sh"]
