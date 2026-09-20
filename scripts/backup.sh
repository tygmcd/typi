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

echo "Starting backup..."

sudo restic \
    --repo "$RESTIC_REPO" \
    --password-file "$PASSWORD_FILE" \
    backup \
    /srv \
    /home/tyler/repos \
    /etc/nginx \
    /etc/systemd/system

echo "Backup complete."

sudo restic \
    --repo "$RESTIC_REPO" \
    --password-file "$PASSWORD_FILE" \
    snapshots