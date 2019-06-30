#!/bin/bash

CONNECT_URL='http://debezium-tutorial_connect_1:8083/'

function initializer_connector {    
    while [[ "$(curl -o /dev/null -w ''%{http_code}'' -X POST -H "Accept:application/json" -H "Content-Type:application/json" ${CONNECT_URL}connectors/ -d @/opt/connect/debezium.json)" != "201" ]]; do 
        sleep 1; 
    done

    echo "CREATED CONNECTOR"
}

initializer_connector &

/docker-entrypoint.sh start
