#!/bin/sh
# MySQL Client - Installs MySQL command line client
set -e

echo ">> Installing MySQL Client..."
apk add --no-cache mysql-client
