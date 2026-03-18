# nginx-base

[![Latest version](https://ghcr-badge.egpl.dev/rijksictgilde/nginx-base/latest_tag?trim=major&label=latest)](https://github.com/RijksICTGilde/nginx-base/pkgs/container/nginx-base)

Hardened, non-root nginx base image for serving static websites in government production environments.

Published to `ghcr.io/rijksictgilde/nginx-base` using [CalVer](https://calver.org/) (`YYYY.MM.PATCH`).

## Usage

In your project's `Dockerfile`:

```dockerfile
FROM ghcr.io/rijksictgilde/nginx-base:2026.03.0

COPY dist/ /usr/share/nginx/html/
```

Then build and run:

```bash
docker build -t my-site .
docker run -p 8080:8080 my-site
```

## What's included

- **Non-root** — runs as uid 101, no root escalation
- **Read-only root filesystem** — only `/tmp` is writable
- **Security headers** — `X-Content-Type-Options`, `X-Frame-Options`, `Referrer-Policy`, `Strict-Transport-Security`
- **Server version hidden** — `server_tokens off`
- **Gzip compression** — for text, JSON, JS, CSS, SVG
- **Static asset caching** — 1 year cache for JS, CSS, images, fonts
- **Port 8080** — unprivileged port, ready for Kubernetes

## Local testing

To quickly test with a local site:

```bash
./build.sh
```

It builds the base image locally, then asks for the path to your site files (defaults to `./example`) and an image name. Run the result with `docker run -p 8080:8080 my-site`.

## Keeping up to date

Add [Dependabot](https://docs.github.com/en/code-security/dependabot) to your project to get automatic PRs when new versions are published:

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: docker
    directory: /
    schedule:
      interval: weekly
```

## CI/CD

Every push to `main` automatically:
1. Runs security tests and [Trivy](https://trivy.dev/) CVE scanning
2. Builds and publishes to GHCR with an auto-incremented CalVer tag
3. Creates a matching git tag

## Cluster compatibility

- Non-root (uid 101)
- Read-only root filesystem (writable `/tmp` only)
- Listens on port 8080
- Minimal footprint: 1 worker, 128 connections
- No `HEALTHCHECK` — use Kubernetes liveness/readiness probes instead
