FROM alpine:3.21.3

RUN apk update && apk add --no-cache \
	mariadb \
	mariadb-client \
	envsubst

RUN mkdir -p /run/mysqld /var/log/mysql

WORKDIR /run/mysqld

RUN chown mysql:mysql /run/mysqld /var/log/mysql

COPY ./conf/mariadb-server.cnf.template /etc/my.cnf.d/

RUN mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

COPY ./tools/docker-entrypoint.sh /run/mariadb/entrypoint.sh

RUN chmod +x /run/mariadb/entrypoint.sh

ENTRYPOINT ["/run/mariadb/entrypoint.sh"]
