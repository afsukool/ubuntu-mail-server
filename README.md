# Ubuntu Mail Server Project

This project provides a comprehensive guide to setting up a mail server on Ubuntu. It will cover the installation and configuration of Postfix (for sending mail), Dovecot (for receiving mail), and other necessary components like spam filtering and SSL/TLS encryption.

## Prerequisites

- A fresh installation of Ubuntu (preferably a server edition).
- A domain name pointed to your server's IP address.
- Root or sudo access to the server.

## Project Structure

The project structure is as follows:

```
ubuntu-mail-server/
├── README.md
├── scripts/
│   ├── install_postfix.sh
│   ├── install_dovecot.sh
│   ├── install_spamassassin.sh
│   ├── configure_ssl.sh
│   └── setup_firewall.sh
└── config/
    ├── postfix/
    │   ├── main.cf
    │   └── master.cf
    ├── dovecot/
    │   ├── dovecot.conf
    │   ├── conf.d/
    │   │   ├── 10-auth.conf
    │   │   ├── 10-mail.conf
    │   │   ├── 10-master.conf
    │   │   └── 10-ssl.conf
    │   └── ssl/
    │       ├── dovecot.pem
    │       └── dovecot.key
    └── spamassassin/
        └── local.cf
```

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/ubuntu-mail-server.git
cd ubuntu-mail-server
```

### 2. Run Installation Scripts

#### Install Postfix

```bash
sudo bash scripts/install_postfix.sh
```

This script installs Postfix and configures it with the basic settings.

#### Install Dovecot

```bash
sudo bash scripts/install_dovecot.sh
```

This script installs Dovecot and configures it for IMAP and POP3 access.

#### Install SpamAssassin

```bash
sudo bash scripts/install_spamassassin.sh
```

This script installs SpamAssassin for spam filtering.

#### Configure SSL/TLS

```bash
sudo bash scripts/configure_ssl.sh
```

This script generates SSL certificates and configures Postfix and Dovecot to use them.

#### Setup Firewall

```bash
sudo bash scripts/setup_firewall.sh
```

This script configures the firewall to allow necessary ports for mail services.

## Configuration Files

### Postfix Configuration (`config/postfix/`)

- `main.cf`: Main configuration file for Postfix.
- `master.cf`: Configuration file for Postfix master process.

### Dovecot Configuration (`config/dovecot/`)

- `dovecot.conf`: Main configuration file for Dovecot.
- `conf.d/`: Directory containing individual configuration files for Dovecot.
  - `10-auth.conf`: Authentication settings.
  - `10-mail.conf`: Mailbox settings.
  - `10-master.conf`: Master process settings.
  - `10-ssl.conf`: SSL/TLS settings.
- `ssl/`: Directory containing SSL certificates for Dovecot.
  - `dovecot.pem`: SSL certificate.
  - `dovecot.key`: SSL key.

### SpamAssassin Configuration (`config/spamassassin/`)

- `local.cf`: Configuration file for SpamAssassin.

## Usage

After running the installation scripts and configuring the server, your mail server should be up and running. You can use any mail client to connect to your server using the configured domain name and credentials.

## Troubleshooting

Check the logs for Postfix and Dovecot for any errors:

```bash
sudo tail -f /var/log/mail.log
sudo tail -f /var/log/mail.err
```

## Contributing

Feel free to fork the repository and submit pull requests for any improvements or bug fixes.

---

## README.md

This `README.md` file provides an overview of the project, installation steps, configuration details, and usage instructions.

## Scripts

### install_postfix.sh

```bash
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
```

### install_dovecot.sh

```bash
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
```

### install_spamassassin.sh

```bash
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
```

### configure_ssl.sh

```bash
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
```

### setup_firewall.sh

```bash
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
```

## Configuration Files

### Postfix Configuration (`config/postfix/main.cf`)

```ini
# See /usr/share/postfix/main.cf.dist for a commented, more complete version

# Debian specific:  Specifying a file name will cause the first
# line of that file to be used as the name.  The Debian default
# is /etc/mailname.
#myorigin = /etc/mailname

smtpd_banner = $myhostname ESMTP $mail_name (Ubuntu)
biff = no

# appending .domain is the MUA's job.
append_dot_mydomain = no

# Uncomment the next line to generate "delayed mail" warnings
#delay_warning_time = 4h

readme_directory = no

# See http://www.postfix.org/COMPATIBILITY_README.html -- default to 2 on
# fresh installs.
compatibility_level = 2

# TLS parameters
smtpd_tls_cert_file=/etc/ssl/certs/mailserver.crt
smtpd_tls_key_file=/etc/ssl/private/mailserver.key
smtpd_use_tls=yes
smtpd_tls_session_cache_database = btree:${data_directory}/smtpd_scache
smtp_tls_session_cache_database = btree:${data_directory}/smtp_scache

# See /usr/share/doc/postfix/TLS_README.gz in the postfix-doc package for
# information on

 enabling SSL in the smtp client.

myhostname = mail.yourdomain.com
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
mydestination = $myhostname, localhost.$mydomain, $mydomain
relayhost = 
mynetworks = 127.0.0.0/8, [::1]/128
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = all
inet_protocols = all
```

### Dovecot Configuration (`config/dovecot/dovecot.conf`)

```ini
# /etc/dovecot/dovecot.conf
log_path = /var/log/dovecot.log
info_log_path = /var/log/dovecot-info.log
log_timestamp = "%Y-%m-%d %H:%M:%S "

ssl = required
ssl_cert = </etc/dovecot/ssl/dovecot.pem
ssl_key = </etc/dovecot/ssl/dovecot.key
```

### SpamAssassin Configuration (`config/spamassassin/local.cf`)

```ini
required_score 5.0
report_safe 0
rewrite_header Subject *****SPAM*****
trusted_networks 192.168.0.0/24
```

---

This setup provides a basic yet functional mail server. For additional features and security, consider integrating DKIM, DMARC, and more robust spam filtering solutions.
