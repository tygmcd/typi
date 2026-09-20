#!/usr/bin/env bash

set -euo pipefail

sudo apt update

sudo apt install -y \
    certbot \
    python3-certbot-dns-cloudflare