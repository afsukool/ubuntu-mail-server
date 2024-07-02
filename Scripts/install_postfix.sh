#!/bin/bash

# Install Postfix
sudo apt update
sudo apt install -y postfix

# Backup original configuration
sudo cp /etc/postfix/main.cf /etc/postfix/main.cf.bak

# Copy the provided configuration
sudo cp ../config/postfix/main.cf /etc/postfix/main.cf
sudo cp ../config/postfix/master.cf /etc/postfix/master.cf

# Restart Postfix to apply changes
sudo systemctl restart postfix
