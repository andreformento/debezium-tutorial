#!/bin/bash

echo "Copy config files if not provided in volume"
cp -rn $KAFKA_HOME/config.orig/* $KAFKA_HOME/config

echo "############ $KAFKA_HOME/bin/"
ls $KAFKA_HOME/bin/

echo "############ $CONFIGS_DIR/"
ls $CONFIGS_DIR/

echo "runing -> $KAFKA_HOME/bin/connect-standalone.sh $CONFIGS_DIR/connect-standalone.properties $CONFIGS_DIR/debezium.properties"
$KAFKA_HOME/bin/connect-standalone.sh $CONFIGS_DIR/connect-standalone.properties $CONFIGS_DIR/debezium.properties
