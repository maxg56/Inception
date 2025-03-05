FROM alpine:3.21.2

# Mettre à jour les paquets et installer Node.js
RUN apk update && apk add nodejs npm

# Copier les fichiers statiques dans le dossier par défaut
COPY ./tools /home/app

# Définir le répertoire de travail
WORKDIR /home/app

# Initialiser un projet Node.js et installer Express
RUN npm init -y && npm install express

# Commande par défaut pour démarrer le serveur
CMD ["node", "server.js"]


