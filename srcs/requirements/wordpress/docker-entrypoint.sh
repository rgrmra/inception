#!/bin/ash

if [ ! -f wp-config.php ];
	then
	until wp config create \
		--dbhost="$MARIADB_HOST:$MARIADB_PORT" \
		--dbname="$MARIADB_DATABASE" \
		--dbuser="$MARIADB_USER" \
		--dbpass="$(cat /run/secrets/mariadb_user_password)" \
		--dbprefix="wp_" \
		--allow-root;
	do
		sleep 5;
	done;
	echo "\$_SERVER['HTTP_HOST'] = '$WORDPRESS_DOMAIN';" >> wp-config.php;
fi

#wp config set WP_REDIS_HOST "redis" --allow-root
#wp config set WP_REDIS_PORT 6379 --raw --allow-root
#wp config set WP_CACHE true --raw --allow-root

if [ ! -f /etc/php83/php-fpm.d/www/conf ]; then
envsubst '$WORDPRESS_PORT' \
	< /etc/php83/php-fpm.d/www.conf.template \
	> /etc/php83/php-fpm.d/www.conf;
fi

if ! wp core is-installed --allow-root;
then

	wp core install \
		--url="$WORDPRESS_DOMAIN" \
		--title="$WORDPRESS_TITLE" \
		--admin_user=$WORDPRESS_USER \
		--admin_password=$(cat /run/secrets/mariadb_user_password) \
		--admin_email=$WORDPRESS_EMAIL \
		--skip-email \
		--allow-root;

	wp theme activate twentytwentyfour --allow-root

	chown -R www-data:inception ./
fi

#wp plugin install redis-cache --activate --allow-root

#wp option set redis_cache_expiration 300 --allow-root

#wp redis enable --allow-root
#wp user create --allow-root	\
#	--path=/var/www/html \
#	"$USER_NAME" "$USER_EMAIL" \
#	--user_pass=$USER_PASSWORD \
#	--role='author'

# Activate the Twenty Twenty-four theme.

echo "wordpress is alive"

exec php-fpm83 -F
