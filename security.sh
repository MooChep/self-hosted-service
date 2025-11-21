#!/bin/bash

set -e

sudo apt update
sudo apt install ufw fail2ban

# Allow ssh before all to ensure connection works with the vm
sudo ufw allow 22
echo -e "\\033[48;5;95;38;5;2140m Port 22 allowed for ssh connexion\\033[0m"

# Actual listen on port 5006 so we allow it
sudo ufw allow 5006
echo Port 5006 allowed

sudo ufw enable

# Copy default config to local config
sudo cp /etc/fail2ban/jail.conf  /etc/fail2ban/jail.local

echo -e "\\033[48;5;95;38;5;2140m Config fail2ban copié vers /etc/fail2ban/jail.local\\033[0m"

# Creating custom filter to detect web enumeration

sudo touch /etc/fail2ban/filter.d/web-enum.conf

sudo bash -c "cat > /etc/fail2ban/filter.d/web-enum.conf" <<EOF

[Definition]
failregex = ^<HOST> - .* "(GET|POST|HEAD).*HTTP.*" 404 .*$
ignoreregex =

EOF


# Create prison and apply filter :

sudo touch /etc/fail2ban/jail.d/web-enum.conf

sudo bash -c "cat > /etc/fail2ban/filter.d/web-enum.conf" <<EOF

[web-enum]
enabled = true
filter = web-enum
action   = iptables-ipset-proto4[name=blacklist, port="http,https", protocol=tcp, bantime=0]
logpath = /var/log/nginx/access.log
findtime = 600
bantime = 7200
maxretry = 4

EOF