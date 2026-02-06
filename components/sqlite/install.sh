#!/bin/sh
# SQLite3 Client - Installs SQLite3 command line interface
set -e

echo ">> Installing SQLite3 Client..."
apk add --no-cache sqlite
