FROM alpine:3.21.3

RUN apk update && apk add --no-cache vsftpd openrc envsubst

RUN mkdir -p /var/run/vsftpd/empty && \
    mkdir -p /home/ftpuser/ftp/upload && \
	mkdir -p /etc/vsftpd && \
    adduser -D -h /home/ftpuser/ftp ftpuser && \
    echo "ftpuser:ftppassword" | tee -a /etc/vsftpd/vsftpd.userlist && \
    chown -R ftpuser:ftpuser /home/ftpuser/ftp

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 21

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
