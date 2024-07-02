#!/bin/bash

# Install Dovecot
sudo apt update
sudo apt install -y dovecot-core dovecot-imapd dovecot-pop3d

# Backup original configuration
sudo cp /etc/dovecot/dovecot.conf /etc/dovecot/dovecot.conf.bak
sudo cp /etc/dovecot/conf.d/10-auth.conf /etc/dovecot/conf.d/10-auth.conf.bak
sudo cp /etc/dovecot/conf.d/10-mail.conf /etc/dovecot/conf.d/10-mail.conf.bak
sudo cp /etc/dovecot/conf.d/10-master.conf /etc/dovecot/conf.d/10-master.conf.bak
sudo cp /etc/dovecot/conf.d/10-ssl.conf /etc/dovecot/conf.d/10-ssl.conf.bak

# Copy the provided configuration
sudo cp ../config/dovecot/dovecot.conf /etc/dovecot/dovecot.conf
sudo cp ../config/dovecot/conf.d/* /etc/dovecot/conf.d/
sudo mkdir -p /etc/dovecot/ssl
sudo cp ../config/dovecot/ssl/* /etc/dovecot/ssl/

# Restart Dovecot to apply changes
sudo systemctl restart dovecot
