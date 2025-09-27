#!/bin/ash

if [ -f /etc/redis.conf.template ];
then
	mv /etc/redis.conf.template /etc/redis.conf;
fi

exec redis-server /etc/redis.conf
