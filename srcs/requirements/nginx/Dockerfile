FROM	alpine:3.21.2

RUN		apk update --no-cache						\
\
		&& apk add --no-cache						\
			openssl									\
			nginx									\
\
		&& rm -f /etc/nginx/http.d/default.conf		\
\
		&& mkdir -p									\
			/etc/nginx/ssl							\
			/var/run/nginx							\
			/var/www/wordpress						\
\
		&& openssl req 								\
			-x509									\
			-nodes									\
			-days 365								\
			-newkey rsa:2048						\
			-out /etc/nginx/ssl/inception.crt		\
			-keyout /etc/nginx/ssl/inception.key	\
			-subj "/C=FR/L=Le Havre/O=42 Le Havre/OU=42/CN=$DOMAIN_NAME/UID=anoteris"	\
\
		&& sed -i 's/^\(\s*\)ssl_protocols\s\+.*/\1ssl_protocols TLSv1.2 TLSv1.3;/' /etc/nginx/nginx.conf

COPY	conf/nginx.conf		/etc/nginx/http.d/nginx.conf

RUN		chmod 755 /var/www/wordpress						

EXPOSE	443

CMD		["nginx", "-g", "daemon off;"]
