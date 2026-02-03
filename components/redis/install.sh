#!/bin/sh
# Redis Client - Installs Redis CLI tools
set -e

echo ">> Installing Redis Client..."
apk add --no-cache redis
