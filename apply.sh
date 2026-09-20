#!/usr/bin/env bash
set -euo pipefail

echo "Applying typi home server configuration..."

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run_step() {
    echo
    echo "==> $1"
    "$2"
}

run_step "Installing Docker" \
    "$ROOT_DIR/bootstrap/install-docker.sh"

run_step "Installing Tailscale" \
    "$ROOT_DIR/bootstrap/install-tailscale.sh"

run_step "Installing nginx" \
    "$ROOT_DIR/bootstrap/install-nginx.sh"

run_step "Installing Certbot" \
    "$ROOT_DIR/bootstrap/install-certbot.sh"

run_step "Configuring certificates" \
    "$ROOT_DIR/bootstrap/configure-certs.sh"

echo
echo "Home server configuration applied successfully."