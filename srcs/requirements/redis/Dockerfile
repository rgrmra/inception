FROM alpine:latest

RUN apk update && apk add redis

COPY ./conf/redis.conf.template /etc/redis.conf

WORKDIR /run/redis

COPY ./tools/docker-entrypoint.sh ./entrypoint.sh

RUN chmod +x ./entrypoint.sh

EXPOSE 6379

ENTRYPOINT ["/run/redis/entrypoint.sh"]
