FROM andreformento/connect-base:0.9.5.Final

LABEL maintainer="Debezium Community"

ENV DEBEZIUM_VERSION="0.9.5.Final" \
    MAVEN_REPO_CORE="https://repo1.maven.org/maven2" \
    MAVEN_DEP_DESTINATION=$KAFKA_CONNECT_PLUGINS_DIR \
    MYSQL_MD5=720b1396358fbdc59bce953f47d3c53f

RUN docker-maven-download debezium mysql "$DEBEZIUM_VERSION" "$MYSQL_MD5"
