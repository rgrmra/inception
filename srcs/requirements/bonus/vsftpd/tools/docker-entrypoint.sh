#!/bin/ash

if [ -f /etc/vsftpd/vsftpd.conf.template ];
then
	envsubst '${VSFTPD_USER}' \
		< /etc/vsftpd/vsftpd.conf.template \
		> /etc/vsftpd/vsftpd.conf;

	mkdir -p /var/run/vsftpd/empty;
	mkdir -p /home/${VSFTPD_USER}/vsftpd/wordpress;
	echo "${VSFTPD_USER}:$(cat /run/secrets/vsftpd_user_password.txt)" | chpasswd;
	echo "${VSFTPD_USER}" > /etc/vsftpd/vsftpd.userlist;
fi

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
