#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

sudo mkdir -p /srv/vaultwarden/data

docker compose \
    -f "$ROOT_DIR/docker/vaultwarden/compose.yaml" \
    up -d