# TyPi IaC

This repository contains the bootstrap and configuration scripts used to rebuild and manage the Typi home server.

The goal is to keep machine configuration reproducible while keeping secrets and persistent application data outside of Git.

## Apply Configuration

Clone the repository onto the server:

```bash
mkdir -p ~/repos
cd ~/repos
git clone <repo-url> typi
cd typi
```

Then apply the configuration:

```bash
./apply.sh
```

The apply script installs and configures services such as Docker, Tailscale, nginx, Certbot, and Restic.

## Manual Setup

Some secrets must be created manually because they must not be committed to Git.

### Cloudflare API Token

Create:

```text
/etc/letsencrypt/secrets/cloudflare.ini
```

with:

```ini
dns_cloudflare_api_token = YOUR_CLOUDFLARE_API_TOKEN
```

Secure it:

```bash
sudo chmod 600 /etc/letsencrypt/secrets/cloudflare.ini
```

The token is used by Certbot to complete DNS challenges for wildcard TLS certificates.

### Restic Password

Create:

```text
/etc/restic/password
```

The file should contain only the Restic repository pa
