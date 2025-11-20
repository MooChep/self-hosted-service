#!/bin/bash
set -e

# Demander à l'utilisateur les informations de la VM
read -p "Utilisateur sur la VM : " VM_USER
read -p "IP ou domaine de la VM : " VM_HOST
read -p "Répertoire de destination sur la VM (ex: ~) : " VM_DIR

SCRIPTS=("build_actual.sh" "setup_daemon.sh" "setup_https.sh")  # Scripts à transférer

# 1/3 - Transfert des scripts vers la VM
for script in "${SCRIPTS[@]}"; do
    echo "Copie de $script vers $VM_USER@$VM_HOST:$VM_DIR"
    scp "$script" "$VM_USER@$VM_HOST:$VM_DIR"
done

# 2/3 - Donner les droits d'exécution
echo "Définition des droits +x sur la VM"
for script in "${SCRIPTS[@]}"; do
    ssh "$VM_USER@$VM_HOST" "chmod +x $VM_DIR/$script"
done

# 3/3 - Vérification
echo "Scripts copiés et droits d'exécution définis !"
ssh "$VM_USER@$VM_HOST" "ls -l $VM_DIR | grep '.sh'"
