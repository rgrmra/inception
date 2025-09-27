#!/bin/ash

if [ -f index.php ];
then
	mkdir -p /var/www/html/wordpress/adminer;
	mv index.php /var/www/html/wordpress/adminer;
fi

echo 'adminer is alive';

exec php-fpm83 -F
