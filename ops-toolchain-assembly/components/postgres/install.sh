#!/bin/bash
# PostgreSQL Client Installer for Alpine Linux
# Installs the latest stable PostgreSQL client tools

set -e

echo "Installing PostgreSQL client..."

# Install PostgreSQL client package from Alpine repositories
# --no-cache: Don't cache the package index (reduces image size)
apk add --no-cache postgresql-client

# Verify installation
if command -v psql &> /dev/null; then
    psql_version=$(psql --version)
    echo "PostgreSQL client installed: $psql_version"
else
    echo "ERROR: PostgreSQL client installation failed"
    exit 1
fi

echo "PostgreSQL client installation complete"
