#!/bin/bash

# Install OpenSSL if not installed
sudo apt update
sudo apt install -y openssl

# Generate SSL certificates
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/mailserver.key -out /etc/ssl/certs/mailserver.crt

# Set permissions
sudo chmod 600 /etc/ssl/private/mailserver.key

# Update Postfix configuration for SSL
sudo postconf -e 'smtpd_tls_cert_file = /etc/ssl/certs/mailserver.crt'
sudo postconf -e 'smtpd_tls_key_file = /etc/ssl/private/mailserver.key'

# Restart Postfix to apply changes
sudo systemctl restart postfix

# Update Dovecot configuration for SSL
sudo cp /etc/ssl/certs/mailserver.crt /etc/dovecot/ssl/dovecot.pem
sudo cp /etc/ssl/private/mailserver.key /etc/dovecot/ssl/dovecot.key

# Restart Dovecot to apply changes
sudo systemctl restart dovecot
