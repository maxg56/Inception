FROM alpine:3.21.2

RUN apk update --no-cache \
    && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

RUN mkdir -p /var/run/nginx

RUN getent group www-data || addgroup -S www-data \
    && getent passwd www-data || adduser -S www-data -G www-data

RUN mkdir -p /var/www/html \
    && chown -R www-data:www-data /var/www/html \
    && chmod 755 /var/www/html

RUN rm /etc/nginx/http.d/default.conf

COPY conf/nginx.conf /etc/nginx/http.d/

CMD [ "nginx", "-g", "daemon off;" ]