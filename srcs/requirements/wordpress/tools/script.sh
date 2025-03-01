#!/bin/sh

set -e

cd /var/www/wordpress

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	wp config create \
		--allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 \
		--path='/var/www/wordpress' \
		--locale=fr_FR
fi
echo "wp-config.php created"
wp core install \
	--url=$DOMAIN_NAME/ \
	--title=$WP_TITLE \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL \
	--skip-email \
	--allow-root \
	--path='/var/www/wordpress'
echo "Wordpress installed"
wp user create $WP_USER_USER $WP_USER_EMAIL \
	--role=author \
	--user_pass=$WP_USER_PASSWORD \
	--allow-root \
	--path='/var/www/wordpress'
echo "User created"
wp theme install astra \
	--activate \
	--allow-root \
	--path='/var/www/wordpress'

mkdir -p /run/php

/usr/sbin/php-fpm83 -F