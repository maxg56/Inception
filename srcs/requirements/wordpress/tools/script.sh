#!/bin/sh

set -e

# Ensure required environment variables are set
: "${SQL_DATABASE:?SQL_DATABASE not set}"
: "${SQL_USER:?SQL_USER not set}"
: "${SQL_PASSWORD:?SQL_PASSWORD not set}"
: "${DOMAIN_NAME:?DOMAIN_NAME not set}"
: "${WP_TITLE:?WP_TITLE not set}"
: "${WP_ADMIN_USER:?WP_ADMIN_USER not set}"
: "${WP_ADMIN_PASSWORD:?WP_ADMIN_PASSWORD not set}"
: "${WP_ADMIN_EMAIL:?WP_ADMIN_EMAIL not set}"
: "${WP_USER_USER:?WP_USER_USER not set}"
: "${WP_USER_EMAIL:?WP_USER_EMAIL not set}"
: "${WP_USER_PASSWORD:?WP_USER_PASSWORD not set}"

# Navigate to the WordPress directory
cd /var/www/wordpress

# Create wp-config.php if it doesn't exist
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
  echo "Creating wp-config.php..."
  wp config create \
    --allow-root \
    --dbname=$SQL_DATABASE \
    --dbuser=$SQL_USER \
    --dbpass=$SQL_PASSWORD \
    --dbhost=mariadb:3306 \
    --path='/var/www/wordpress' \
    --locale=fr_FR
  echo "wp-config.php created"
fi

# Install WordPress if not already installed
if ! wp core is-installed --path='/var/www/wordpress'; then
  echo "Installing WordPress..."
  wp core install \
    --url=$DOMAIN_NAME/ \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USER \
    --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL \
    --skip-email \
    --allow-root \
    --path='/var/www/wordpress'
  echo "WordPress installed"
else
  echo "WordPress is already installed."
fi

# Check if user already exists
if ! wp user get $WP_USER_USER --path='/var/www/wordpress' > /dev/null 2>&1; then
  # Create the user if it doesn't exist
  echo "Creating WordPress user..."
  wp user create $WP_USER_USER $WP_USER_EMAIL \
    --role=author \
    --user_pass=$WP_USER_PASSWORD \
    --allow-root \
    --path='/var/www/wordpress'
  echo "User created"
else
  echo "User $WP_USER_USER already exists."
fi

# Install and activate the Astra theme
echo "Installing Astra theme..."
wp theme install astra \
  --activate \
  --allow-root \
  --path='/var/www/wordpress'
echo "Astra theme activated"

# Ensure the PHP-FPM socket directory exists
mkdir -p /run/php

# Start PHP-FPM
echo "Starting PHP-FPM..."
/usr/sbin/php-fpm83 -F
