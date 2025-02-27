FROM alpine:3.21.2

RUN apk update --no-cache \
    && apk add --no-cache mariadb-client mariadb

COPY conf/my.cnf /etc/my.cnf