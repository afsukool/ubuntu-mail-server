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
