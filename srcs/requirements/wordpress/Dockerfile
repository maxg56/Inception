FROM alpine:3.21.2

RUN apk update --no-cache \
    && apk add --no-cache wget php83 php83-fpm php83-mbstring php83-phar \
    php83-mysqli mariadb-client \
    && wget https://wordpress.org/wordpress-6.7.2.tar.gz -P /var/www \
    && cd /var/www \
    && tar -xzf wordpress-6.7.2.tar.gz \
    && rm wordpress-6.7.2.tar.gz \
    && chown -R root:root /var/www/wordpress \
    && wget -O /usr/local/bin/wp https://github.com/wp-cli/wp-cli/releases/download/v2.11.0/wp-cli-2.11.0.phar \
    && chmod +x /usr/local/bin/wp

COPY conf/www.conf /etc/php83/php-fpm.d/www.conf

COPY tools/script.sh /tools/script.sh
RUN chmod +x /tools/script.sh

CMD [ "/tools/script.sh" ]
