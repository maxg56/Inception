FROM alpine:3.21.2

# Installer vsftpd et bash
RUN apk add --no-cache vsftpd bash

# Ajouter un utilisateur FTP et définir son mot de passe
ARG FTP_USER="ftpuser"
ARG FTP_PASS="ftp_password"
RUN adduser -h /home/$FTP_USER -s /bin/sh -D $FTP_USER && \
    echo "$FTP_USER:$FTP_PASS" | chpasswd

# Créer le dossier FTP et assigner les permissions
RUN mkdir -p /home/$FTP_USER && \
    chown -R $FTP_USER:$FTP_USER /home/$FTP_USER

# Copier la configuration FTP
COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

# Ouvrir les ports FTP et passifs
EXPOSE 21 40000-50000

# Lancer vsftpd
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]

