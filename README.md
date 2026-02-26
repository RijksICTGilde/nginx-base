# nginx-base

Minimal nginx container for serving static websites. Runs as non-root on a read-only filesystem.

## Quick start

Run the build script and follow the prompts:

```bash
./build.sh
```

It will ask for:
- The path to your website files (e.g. `../my-project/dist`)
- An image name and tag (defaults to `my-site:latest`)

The script copies your site into `public/`, builds the Docker image, and you're ready to go:

```bash
docker run -p 8080:8080 my-site:latest
```

## Manual usage

If you prefer to skip the script:

1. Copy your static site files into the `public/` directory
2. Build: `docker build -t my-site .`
3. Run: `docker run -p 8080:8080 my-site`

## Cluster compatibility

- Runs as non-root (uid 101)
- Read-only root filesystem (writable `/tmp` only)
- Listens on port 8080
- Minimal footprint: 1 worker, 128 connections
