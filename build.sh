#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PUBLIC_DIR="${SCRIPT_DIR}/public"

read -rp "Path to website files: " SITE_PATH

if [ ! -d "$SITE_PATH" ]; then
    echo "Error: '${SITE_PATH}' is not a directory"
    exit 1
fi

if [ ! -f "${SITE_PATH}/index.html" ]; then
    echo "Warning: no index.html found in '${SITE_PATH}'"
    read -rp "Continue anyway? [y/N] " CONFIRM
    [[ "$CONFIRM" =~ ^[Yy]$ ]] || exit 1
fi

read -rp "Image name [my-site]: " IMAGE_NAME
IMAGE_NAME="${IMAGE_NAME:-my-site}"

read -rp "Image tag [latest]: " IMAGE_TAG
IMAGE_TAG="${IMAGE_TAG:-latest}"

echo "Copying website files..."
rm -rf "${PUBLIC_DIR:?}"/*
cp -a "${SITE_PATH}"/. "${PUBLIC_DIR}/"
echo "Copied to public/"

echo "Building ${IMAGE_NAME}:${IMAGE_TAG}..."
docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" "${SCRIPT_DIR}"

echo ""
echo "Done! Run with:"
echo "  docker run -p 8080:8080 ${IMAGE_NAME}:${IMAGE_TAG}"
