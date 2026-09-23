#!/usr/bin/env bash
set -euo pipefail

echo "Applying typi home server configuration..."

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run_step() {
    echo
    echo "==> $1"
    "$2"
}

# General system configuration
run_step "Installing Docker" \
    "$ROOT_DIR/bootstrap/install-docker.sh"

run_step "Installing Tailscale" \
    "$ROOT_DIR/bootstrap/install-tailscale.sh"

run_step "Installing Restic" \
    "$ROOT_DIR/bootstrap/install-restic.sh"

run_step "Installing nginx" \
    "$ROOT_DIR/bootstrap/install-nginx.sh"

run_step "Installing Certbot" \
    "$ROOT_DIR/bootstrap/install-certbot.sh"

run_step "Installing SQLite" \
    "$ROOT_DIR/bootstrap/install-sqlite.sh"

run_step "Installing UFW" \
    "$ROOT_DIR/bootstrap/install-ufw.sh"

run_step "Installing Fail2Ban" \
    "$ROOT_DIR/bootstrap/install-fail2ban.sh"

run_step "Configuring certs" \
    "$ROOT_DIR/bootstrap/configure-certs.sh"

run_step "Configuring automatic security updates" \
    "$ROOT_DIR/bootstrap/configure-auto-updates.sh"

# Docker apps
run_step "Configuring Vaultwarden" \
    "$ROOT_DIR/bootstrap/configure-vaultwarden.sh"

echo
echo "Home server configuration applied successfully."