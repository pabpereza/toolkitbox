#!/bin/bash
# AWS CLI Installer for Alpine Linux
# Installs AWS Command Line Interface version 2

set -e

echo "Installing AWS CLI..."

# Install AWS CLI from Alpine repositories
# --no-cache: Don't cache the package index (reduces image size)
apk add --no-cache aws-cli

# Verify installation
if command -v aws &> /dev/null; then
    aws_version=$(aws --version 2>&1)
    echo "AWS CLI installed: $aws_version"
else
    echo "ERROR: AWS CLI installation failed"
    exit 1
fi

echo "AWS CLI installation complete"
