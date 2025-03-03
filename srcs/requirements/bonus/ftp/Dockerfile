# SPECIFIE LA DISTRIBUTION
FROM alpine:3.21.2

# Mise à jour et installation des paquets nécessaires
RUN apk update  --no-cache &&  \
    apk add --no-cache iputils vsftpd openrc shadow

# Copier la configuration de vsftpd et le script
COPY ./conf/vsftpd.conf /etc/
COPY ./tools/script.sh /tmp/

# Donner les permissions d'exécution au script
RUN chmod +x /tmp/script.sh

# Entrée du conteneur
ENTRYPOINT ["/tmp/script.sh"]
