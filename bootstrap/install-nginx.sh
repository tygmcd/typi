#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="nginx/sites"
DEST_DIR="/etc/nginx/sites-available"
ENABLED_DIR="/etc/nginx/sites-enabled"

sudo apt update
sudo apt install -y nginx

changed=false

for source in "$SOURCE_DIR"/*.conf; do
    [ -e "$source" ] || continue

    filename="$(basename "$source")"
    site_name="${filename%.conf}"

    dest="$DEST_DIR/$site_name"
    enabled="$ENABLED_DIR/$site_name"

    if ! sudo cmp -s "$source" "$dest"; then
        sudo cp "$source" "$dest"
        changed=true
    fi

    sudo ln -sfn "$dest" "$enabled"
done

sudo nginx -t

if [ "$changed" = true ]; then
    sudo systemctl reload nginx
fi

sudo systemctl enable nginx