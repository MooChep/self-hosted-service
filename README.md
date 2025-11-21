## Préface du projet :  

Notre objectif pour ce projet est d’installer un service sur un serveur Debian 13. 
Le service que nous avons choisi est **Actual Budget Vision**. 

Pour ce projet, nous sommes en duo, n'avons pas le droit d’utiliser l’IA ni Docker. Nous devrons réaliser des scripts d’automatisation et émettre des liens entre notre projet et les concepts théoriques de notre cours.  

Pour le côté technique, on doit : avoir un service systemd fonctionnel, sécuriser ce service, gérer les backups et monitorer son activité. 

## Configuration du projet :  

Le projet a été réalisé sur une VM Debian hostée sur un serveur Proxmox. 

### Specs de la VM :  

- Debian 13.1.0
- 4 vcpu
- 4Go RAM *
- 32Go Disk 

*La RAM de la VM ou de la machine physique doit être au minimum de 4go pour le build d’Actual. 

### Accès VM : 

Avec un accès VPN pour se connecter au réseau privé du serveur Proxmox 

Tout le projet a été créé via SSH. 

## Actual Budget : 

L’outil Actual Budget est une application rapide et sécurisée pour gérer ses finances, comptes et budgets. 

Le dépot github d’Actual et sa documentation pour build from source 

## Reproduire le projet : 

Si vous souhaitez, vous aussi héberger Actual Budget sur votre propre serveur voici notre guide étapes par étapes pour gérer vous-même vos finances. 

### Script build_actual.sh 

Ce script suit la documentation officielle pour build le projet Actual. 

Installer Node, Git et Yarn via le package manager (apt sur debian) 

Copier le dépôt github d’Actual (les sources) 

Nettoyer les dossiers existant pour eviter les conflits (rm -rf) 

Installation des dépendances et build du projet. 

### Script setup_daemon.sh 

Ce script permet de créer un daemon systemd afin de pouvoir accéder à Actual dès la mise en route de la VM. On peut verifier son status (systemctl status actual-server.service). 

Explication des étapes :  

Création du fichier du service 

Rechargement des services systemd et activation du service 

Démarrage du service 

### Script backup.sh 

Sauvegarde des fichiers Actual dans un dossier protégé. 
Tout d’abord, il faudra enregistrer le mot de passe que vous souhaitez mettre pour votre fichier backup dans /var/restic_password pour que le script s’exécute correctement 
 
- Initialisation d’un dépôt restic 
- Sauvegarde du fichier actual 
- Vérification de la sauvegarde du fichier 

Pour pouvoir récupérer le backup, il faut : 

Créer un dossier sauvegarde : mkdir ~/sauvegarde 

Récupérer les données et les mettre dans le dossier sauvegarde : 

restic -r [chemin dépôt restic] mount ~/sauvegarde 

### Script security.sh 

Ce script permet de sécuriser les ports et de filtrer les connexions. 

Explication des étapes :  

Installer ufw (firewall) et fail2ban (prévention d’intrusion) 

Ouvrir les ports uniquement nécessaires au service (+ssh pour configurer depuis un host distant et maintenir la connectivité à distance) 

Configurer fail2ban pour filtrer les tentatives d’énumération web 

Ajouter le filtre à la configuration du service. 

 

### \[BONUS\] Script deploy.sh 

Permet de copier les scripts sur un host distant via SSH afin de déployer Actual facilement autrement que via git clone. 

Copie des scripts via scp vers la machine distante. 

Ce script a été très utile pour simplifier le deploiement du projet sur une nouvelle VM avant la création du dépot github. 

 

 

 

 

 

 

 

 

 
