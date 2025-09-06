FROM alpine:3.21.3

RUN apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-curl \
    php83-xml \
    php83-zlib \
    php83-mbstring \
    php83-opcache \
	php83-phar \
	php83-pecl-redis \
    curl \
	envsubst

RUN mkdir -p /run/wordpress /var/www/html/wordpress

WORKDIR /var/www/html/wordpress

RUN addgroup -g 1000 inception

RUN adduser -D -H -s /bin/ash -G www-data www-data

RUN addgroup www-data inception

RUN chown -R www-data:inception ./

RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -xzvf latest.tar.gz \
    && rm latest.tar.gz \
    && cp -R wordpress/* . \
    && rm -rf wordpress

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /bin/wp

COPY ./conf/www.conf.template /etc/php83/php-fpm.d/

COPY ./tools/docker-entrypoint.sh /run/wordpress/entrypoint.sh

RUN chmod +x /run/wordpress/entrypoint.sh

CMD ["/run/wordpress/entrypoint.sh"]
