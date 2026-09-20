#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt install -y nginx

SOURCE="nginx/sites/cockpit.conf"
DEST="/etc/nginx/sites-available/cockpit"

changed=false

if ! sudo cmp -s "$SOURCE" "$DEST"; then
    sudo cp "$SOURCE" "$DEST"
    changed=true
fi

sudo ln -sfn \
    /etc/nginx/sites-available/cockpit \
    /etc/nginx/sites-enabled/cockpit

sudo nginx -t

if [ "$changed" = true ]; then
    sudo systemctl reload nginx
fi

sudo systemctl enable nginx