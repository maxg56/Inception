#!/bin/sh

# Créer le répertoire nécessaire pour secure_chroot_dir si ce n'est pas déjà fait
mkdir -p /var/run/vsftpd/empty
chown root:root /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

# Ajouter un utilisateur FTP si nécessaire
if ! id "$FTP_USER" &>/dev/null; then
    echo "Création de l'utilisateur $FTP_USER"
    useradd -m $FTP_USER
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
    chown $FTP_USER:$FTP_USER -R /home/$FTP_USER/
    echo "$FTP_USER" | tee -a /etc/vsftpd.userlist || echo "Impossible d'ajouter l'utilisateur $FTP_USER à la liste des utilisateurs autorisés"
fi
# Démarrer vsftpd directement sans openrc
/usr/sbin/vsftpd /etc/vsftpd.conf