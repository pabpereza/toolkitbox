#!/bin/sh
# Google Cloud SDK - Installs gcloud command line interface
set -e

VERSION="503.0.0"

echo ">> Installing Google Cloud SDK dependencies..."
apk add --no-cache curl python3 bash

# Detect architecture
ARCH=$(uname -m)
case "$ARCH" in
    x86_64)  ARCH_NAME="x86_64" ;;
    aarch64) ARCH_NAME="arm" ;;
    *)       echo ">> ERROR: Unsupported architecture: $ARCH"; exit 1 ;;
esac

echo ">> Downloading Google Cloud SDK ${VERSION}..."
curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${VERSION}-linux-${ARCH_NAME}.tar.gz" -o /tmp/gcloud.tar.gz

echo ">> Extracting Google Cloud SDK..."
tar -xzf /tmp/gcloud.tar.gz -C /opt
/opt/google-cloud-sdk/install.sh --quiet --path-update true

echo ">> Creating symlinks..."
ln -sf /opt/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud
ln -sf /opt/google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil
ln -sf /opt/google-cloud-sdk/bin/bq /usr/local/bin/bq

echo ">> Cleaning up..."
rm -rf /tmp/gcloud.tar.gz
