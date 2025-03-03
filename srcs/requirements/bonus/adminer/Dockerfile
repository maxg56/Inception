# Utiliser Alpine comme base
FROM alpine:3.21.2

# Installer PHP et les extensions nécessaires
RUN apk add --no-cache php php-mysqli php-session php-json wget

# Créer le dossier pour Adminer et le télécharger
RUN mkdir -p /var/www/html && \
    wget -O /var/www/html/index.php https://www.adminer.org/latest.php

EXPOSE 8080

# Lancer Adminer avec PHP en mode serveur
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]

