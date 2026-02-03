#!/bin/sh
# AWS CLI - Installs AWS Command Line Interface
set -e

echo ">> Installing AWS CLI..."
apk add --no-cache aws-cli
