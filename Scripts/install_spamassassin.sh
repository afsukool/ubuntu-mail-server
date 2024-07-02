#!/bin/bash

# Install SpamAssassin
sudo apt update
sudo apt install -y spamassassin spamc

# Enable SpamAssassin
sudo sed -i 's/ENABLED=0/ENABLED=1/' /etc/default/spamassassin

# Backup original configuration
sudo cp /etc/spamassassin/local.cf /etc/spamassassin/local.cf.bak

# Copy the provided configuration
sudo cp ../config/spamassassin/local.cf /etc/spamassassin/local.cf

# Restart SpamAssassin to apply changes
sudo systemctl restart spamassassin
