FROM mysql:5.7

LABEL maintainer "André Formento <andreformento.sc@gmail.com>"

COPY mysql.cnf /etc/mysql/conf.d/
COPY inventory.sql /docker-entrypoint-initdb.d/
