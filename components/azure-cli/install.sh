#!/bin/sh
# Azure CLI - Installs Azure command line interface
set -e

echo ">> Installing Azure CLI..."
apk add --no-cache py3-pip gcc musl-dev python3-dev libffi-dev openssl-dev cargo make

echo ">> Installing Azure CLI via pip..."
pip3 install --no-cache-dir azure-cli --break-system-packages

echo ">> Cleaning up build dependencies..."
apk del gcc musl-dev python3-dev libffi-dev openssl-dev cargo make
