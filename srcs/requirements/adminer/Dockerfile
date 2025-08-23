FROM alpine:latest

RUN apk update && apk add --no-cache php83 php83-fpm

COPY ./entrypoint.sh /usr/local/bin/

RUN chmod 755 /usr/local/bin/entrypoint.sh

ENTRYPOINT  ["/usr/local/bin/entrypoint.sh"]
