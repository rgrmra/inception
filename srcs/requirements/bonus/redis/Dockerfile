FROM alpine:3.21

RUN apk add --no-cache \
    redis

WORKDIR /run/redis

COPY ./conf/redis.conf.template /etc

COPY ./tools/docker-entrypoint.sh ./entrypoint.sh

RUN chmod +x ./entrypoint.sh

CMD ["/run/redis/entrypoint.sh"]
