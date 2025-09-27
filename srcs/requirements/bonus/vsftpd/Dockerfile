FROM alpine:3.21.4

ARG VSFTPD_USER

RUN apk add --no-cache \
    vsftpd \
    envsubst

RUN addgroup -g 1000 inception \
    && adduser -D -H ${VSFTPD_USER} \
    && addgroup ${VSFTPD_USER} inception

RUN echo "/sbin/nologin" >> /etc/shells

WORKDIR /run/vsftpd

COPY ./conf/vsftpd.conf.template /etc/vsftpd

COPY ./tools/docker-entrypoint.sh ./entrypoint.sh

RUN chmod +x /run/vsftpd/entrypoint.sh

CMD ["/run/vsftpd/entrypoint.sh"]
