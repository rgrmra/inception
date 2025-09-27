FROM alpine:3.21

RUN apk add --no-cache \
    php83 \
    php83-fpm \
    php83-session \
    php83-mysqli \
    php83-pdo_mysql \
    php83-mbstring \
    php83-json \
    php83-iconv \
    wget

WORKDIR /run/adminer

RUN addgroup -g 1000 inception \
    && adduser -D -H -s /bin/ash -G www-data www-data \
    && addgroup www-data inception

RUN wget http://www.adminer.org/latest.php -O index.php

COPY ./conf/www.conf.template /etc/php83/php-fpm.d/www.conf

COPY ./tools/docker-entrypoint.sh /run/adminer/entrypoint.sh

RUN chmod +x /run/adminer/entrypoint.sh

CMD ["/run/adminer/entrypoint.sh"]
