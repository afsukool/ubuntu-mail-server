#!/bin/bash

# Install UFW if not installed
sudo apt update
sudo apt install -y ufw

# Allow necessary ports
sudo ufw allow 25/tcp    # SMTP
sudo ufw allow 143/tcp   # IMAP
sudo ufw allow 110/tcp   # POP3
sudo ufw allow 993/tcp   # IMAPS
sudo ufw allow 995/tcp   # POP3S
sudo ufw allow 587/tcp   # Submission

# Enable UFW
sudo ufw enable
