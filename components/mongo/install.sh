#!/bin/sh
# MongoDB Client - Installs MongoDB Shell (mongosh)
set -e

MONGOSH_VERSION="2.3.0"

echo ">> Installing MongoDB Client..."
apk add --no-cache curl

# Detect architecture
ARCH=$(uname -m)
case "$ARCH" in
    x86_64)  MONGOSH_ARCH="x64" ;;
    aarch64) MONGOSH_ARCH="arm64" ;;
    *)       echo ">> ERROR: Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Download and install mongosh
echo ">> Downloading mongosh ${MONGOSH_VERSION} for ${MONGOSH_ARCH}..."
curl -fsSL "https://downloads.mongodb.com/compass/mongosh-${MONGOSH_VERSION}-linux-${MONGOSH_ARCH}.tgz" -o /tmp/mongosh.tgz
tar -xzf /tmp/mongosh.tgz -C /tmp
cp /tmp/mongosh-${MONGOSH_VERSION}-linux-${MONGOSH_ARCH}/bin/mongosh /usr/local/bin/
chmod +x /usr/local/bin/mongosh

# Cleanup
rm -rf /tmp/mongosh*
