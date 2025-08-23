FROM alpine:3.21.3

ARG SHARED_GROUP=inception

RUN apk update && apk add --no-cache vsftpd envsubst

RUN addgroup -g 1000 ${SHARED_GROUP}

RUN echo "/sbin/nologin" >> /etc/shells

RUN mkdir -p /var/run/vsftpd/empty && \
    mkdir -p /home/ftpuser/vsftpd/wordpress && \
	mkdir -p /homr/ftpuser/vsftpd/static_site && \
    adduser -D -h /home/ftpuser/ftp ftpuser && \
    echo "ftpuser:ftppassword" | chpasswd && \
    echo "ftpuser" > /etc/vsftpd/vsftpd.userlist && \
    chown -R ftpuser:${SHARED_GROUP} /home/ftpuser/ftp

RUN chmod -R 755 /home/ftpuser

RUN addgroup ftpuser ${SHARED_GROUP}

WORKDIR /home/ftpuser/ftp

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
