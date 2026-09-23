#!/usr/bin/env bash

set -euo pipefail

sudo apt update
sudo apt install -y fail2ban

sudo systemctl enable --now fail2ban
sudo systemctl status fail2ban