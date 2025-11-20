#!/bin/bash 
set -e
sudo restic -r /actual init


sudo restic -r /actual backup .

sudo restic -r /actual snapshots
