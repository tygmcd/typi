#!/usr/bin/env bash

set -euo pipefail

sudo apt update

sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades