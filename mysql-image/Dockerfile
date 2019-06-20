FROM mysql:5.7

LABEL maintainer="André Formento"

COPY mysql.cnf /etc/mysql/conf.d/
COPY inventory.sql /docker-entrypoint-initdb.d/
