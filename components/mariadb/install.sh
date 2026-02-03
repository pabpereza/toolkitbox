#!/bin/sh
# MariaDB Client - Installs MariaDB command line client
set -e

echo ">> Installing MariaDB Client..."
apk add --no-cache mariadb-client
