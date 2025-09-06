FROM alpine:3.22.1

RUN apk add --no-cache wget php83 php83-fpm php83-session

RUN apk add --no-cache php83-mysqli php83-pdo_mysql

RUN apk add --no-cache php83-mbstring php83-json php83-iconv

RUN addgroup -g 1000 inception

RUN adduser -D -H -s /bin/ash -G www-data www-data

RUN addgroup www-data inception

COPY ./conf/www.conf.template /etc/php83/php-fpm.d/www.conf

COPY ./tools/docker-entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT  ["/usr/local/bin/entrypoint.sh"]
