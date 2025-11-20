#!/bin/bash
set -e

# Variables
ACTUAL_DIR="$HOME/actual"
RELEASE_URL="https://github.com/actualbudget/actual/archive/refs/tags/v25.11.0.tar.gz"

# 1/7 - Mise à jour du système
sudo apt-get update -y
sudo apt-get upgrade -y

# 2/7 - Installation de Node.js LTS (version 22)
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
sudo apt-get install -y nodejs

# 3/7 - Installation de Git et Yarn
sudo apt-get install -y git
sudo npm install --global yarn

# 4/7 - Suppression de l'ancienne installation (si elle existe)
sudo rm -rf "$ACTUAL_DIR"

# 5/7 - Téléchargement et extraction de la release officielle
mkdir -p "$ACTUAL_DIR"
curl -L "$RELEASE_URL" | tar xz --strip-components=1 -C "$ACTUAL_DIR"

cd "$ACTUAL_DIR"

# 6/7 - Installation des dépendances Node.js du serveur
yarn install

# 7/7 - Build du serveur Actual
yarn build:server

