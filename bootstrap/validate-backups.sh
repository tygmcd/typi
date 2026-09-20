#!/usr/bin/env bash
set -euo pipefail

BACKUP_MOUNT="/mnt/backup"
RESTIC_REPO="$BACKUP_MOUNT/typi/restic"

if ! mountpoint -q "$BACKUP_MOUNT"; then
    echo "Backup drive is not mounted at $BACKUP_MOUNT"
    exit 1
fi

mkdir -p "$RESTIC_REPO"

if [ ! -f "$RESTIC_REPO/config" ]; then
    echo "Restic repository is not initialized."
    echo "Run:"
    echo "  restic -r $RESTIC_REPO init"
    exit 1
fi

echo "Backup repository is configured."