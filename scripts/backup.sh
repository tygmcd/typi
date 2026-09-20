#!/usr/bin/env bash
set -euo pipefail

BACKUP_MOUNT="/mnt/backup"
RESTIC_REPO="$BACKUP_MOUNT/typi/restic"
PASSWORD_FILE="/etc/restic/password"

if ! mountpoint -q "$BACKUP_MOUNT"; then
    echo "Backup drive is not mounted at $BACKUP_MOUNT"
    exit 1
fi

if [ ! -f "$PASSWORD_FILE" ]; then
    echo "Missing Restic password file: $PASSWORD_FILE"
    exit 1
fi

# Backup databases
echo "Backing up Vaultwarden database..."

VAULTWARDEN_DATA="/srv/vaultwarden/data"
VAULTWARDEN_BACKUP="/srv/vaultwarden/backup"

sudo mkdir -p "$VAULTWARDEN_BACKUP"

sudo sqlite3 \
    "$VAULTWARDEN_DATA/db.sqlite3" \
    ".backup '$VAULTWARDEN_BACKUP/db.sqlite3'"

# Refresh and freeze package inventory
echo "Refreshing package inventory..."

dpkg --get-selections \
  | sudo tee /var/backups/package-list.txt > /dev/null

snap list \
  | sudo tee /var/backups/snap-list.txt > /dev/null

echo "Starting backup..."

sudo restic \
    --repo "$RESTIC_REPO" \
    --password-file "$PASSWORD_FILE" \
    backup \
    /srv \
    /home/tyler/repos \
    /etc/nginx \
    /etc/systemd/system \
    /etc/fstab \
    /etc/netplan \
    /etc/letsencrypt \
    /var/backups

echo "Backup complete."

sudo restic \
    --repo "$RESTIC_REPO" \
    --password-file "$PASSWORD_FILE" \
    snapshots