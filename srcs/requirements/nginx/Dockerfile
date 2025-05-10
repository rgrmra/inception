FROM alpine:3.21.3

RUN apk update

RUN apk add --no-cache nginx openssl envsubst

RUN mkdir -p /run/nginx /etc/nginx/ssl

WORKDIR /run/nginx

COPY ./conf/nginx.conf.template /etc/nginx/

COPY ./docker-entrypoint.sh /run/nginx/entrypoint.sh

RUN chmod +x /run/nginx/entrypoint.sh

ENTRYPOINT ["/run/nginx/entrypoint.sh"]
