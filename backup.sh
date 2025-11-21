#!/bin/bash 
set -e

echo code > /var/restic_password

restic -r /tmp/restic-repo init -p /var/restic_password

restic -r /tmp/restic-repo backup ~/actual -p /var/restic_password

restic -r /tmp/restic-repo snapshots -p /var/restic_password
