#!/bin/bash
set -e

# Chemin du service systemd
SERVICE_PATH="/etc/systemd/system/actual-server.service"
ACTUAL_DIR="$HOME/actual"

# 1/3 - Création du fichier de service systemd pour démarrage automatique
sudo bash -c "cat > $SERVICE_PATH" <<EOF
[Unit]
Description=Actual-Server (https://actualbudget.org)
After=network.target

[Service]
WorkingDirectory=$ACTUAL_DIR
ExecStart=/usr/bin/yarn start:server
Restart=always
RestartSec=10
Environment=NODE_ENV=production
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

# 2/3 - Rechargement des services systemd et activation du service
sudo systemctl daemon-reload
sudo systemctl enable actual-server

# 3/3 - Démarrage du service
sudo systemctl restart actual-server
