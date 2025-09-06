#!/bin/ash

# Set up php-fpm
#mkdir -p /var/run/php
#sed -i 's/listen = \/run\/php\/php83-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php83/fpm/pool.d/www.conf

# Set up adminer
mkdir -p /var/www/html/wordpress/adminer
wget "http://www.adminer.org/latest.php" -O /var/www/html/wordpress/adminer/index.php
chown 1000:1000 /var/www/html/wordpress/adminer/index.php
chmod 755 /var/www/html/wordpress/adminer/index.php

# Start php-fpm
exec php-fpm83 -F
