#!/bin/sh
# PostgreSQL Client - Installs the latest stable PostgreSQL client tools
set -e

echo ">> Installing PostgreSQL Client..."
apk add --no-cache postgresql-client
