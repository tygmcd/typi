#!/usr/bin/env bash
set -euo pipefail

CREDENTIALS_FILE="/etc/letsencrypt/secrets/cloudflare.ini"
CERT_NAME="tygmcd.com"

if ! sudo test -f "$CREDENTIALS_FILE"; then
    echo "Missing Cloudflare credentials: $CREDENTIALS_FILE"
    exit 1
fi

sudo chmod 600 "$CREDENTIALS_FILE"

if sudo certbot certificates 2>/dev/null | grep -q "Certificate Name: $CERT_NAME"; then
    echo "Wildcard certificate already exists."
    exit 0
fi

sudo certbot certonly \
    --dns-cloudflare \
    --dns-cloudflare-credentials "$CREDENTIALS_FILE" \
    --cert-name "$CERT_NAME" \
    -d tygmcd.com \
    -d '*.tygmcd.com'