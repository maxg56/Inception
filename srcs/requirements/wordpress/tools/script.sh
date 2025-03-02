#!/bin/sh
set -e

cd /var/www/wordpress

until mysql -h mariadb -u $SQL_USER -p$SQL_PASSWORD -e "SELECT 1" > /dev/null 2>&1; do
  echo "Waiting for MariaDB to be ready..."
  sleep 5
done


# Vérifier si WordPress est déjà installé
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    echo "WordPress is not installed yet. Installing WordPress..."
    wp config create \
        --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/wordpress' \
        --locale=fr_FR
else
    echo "[1]WordPress is already installed."
fi

if ! wp core is-installed --path='/var/www/wordpress'; then
    wp core install \
        --url="$DOMAIN_NAME/" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root \
        --path='/var/www/wordpress'
else
    echo "[2] WordPress is already installed."
fi

if ! wp user get "$WP_USER_USER" --path='/var/www/wordpress'; then
    wp user create "$WP_USER_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root \
        --path='/var/www/wordpress'
else
    echo "[3] User $WP_USER_USER already exists."
fi

if ! wp theme is-installed astra --path='/var/www/wordpress'; then
    wp theme install astra --activate --allow-root --path='/var/www/wordpress'
else
    echo "[4] Astra theme is already installed."
fi


mkdir -p /run/php

echo "Starting PHP-FPM..."
/usr/sbin/php-fpm83 -F