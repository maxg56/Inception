FROM alpine:3.21.2

# Définir une variable d'environnement pour le répertoire des données
ENV DATA_DIR=/app/data

# Installation des dépendances système et préparation du répertoire
RUN apk add --no-cache \
    nodejs \
    npm \
    git \
    python3 \
    build-base \
    && mkdir -p /app \
    && cd /app \
    && git clone https://github.com/louislam/uptime-kuma.git UptimeKuma \
    && cd UptimeKuma/ \
    && npm install --production --omit=dev \
    && npm run download-dist \
    && npm install pm2 -g \
    && pm2 install pm2-logrotate \
    && echo "Setup complete"

# Définir le répertoire de travail
WORKDIR /app/UptimeKuma

# Exposer le port par défaut
EXPOSE 3001
COPY tooks/db-config.json /app/data/db-config.json

CMD ["pm2", "start", "server/server.js", "--no-daemon"]

