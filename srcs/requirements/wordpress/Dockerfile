FROM alpine:3.21.2

# Définition des URLs pour éviter les répétitions
ENV WP_VERSION=6.7.2 \
    WP_CLI_VERSION=2.11.0 \
    WP_CLI_URL=https://github.com/wp-cli/wp-cli/releases/download/v2.11.0/wp-cli-2.11.0.phar \
    WP_URL=https://wordpress.org/wordpress-6.7.2.tar.gz

# Installation des dépendances et téléchargement de WordPress + WP-CLI

RUN apk update --no-cache \
    && apk add --no-cache wget php83 php83-fpm php83-mbstring php83-phar php83-tokenizer php83-mysqli mariadb-client \
    && wget -q $WP_URL -P /var/www \
    && tar -xzf /var/www/wordpress-${WP_VERSION}.tar.gz -C /var/www \
    && rm /var/www/wordpress-${WP_VERSION}.tar.gz \
    && adduser -D -G www-data -u 82 www-data \
    && chown -R www-data:www-data /var/www/wordpress \
    && wget -q -O /usr/local/bin/wp $WP_CLI_URL \
    && chmod +x /usr/local/bin/wp

# Configuration de PHP-FPM
COPY conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY tools/script.sh /tools/script.sh

RUN chmod +x /tools/script.sh

# Commande d’exécution du conteneur
CMD [ "/tools/script.sh" ]
