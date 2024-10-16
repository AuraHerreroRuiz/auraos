#!/usr/bin/env bash

# Download binary
set -oue pipefail
mkdir -p /tmp/keymapp-download
# From https://www.zsa.io/flash
wget https://oryx.nyc3.cdn.digitaloceanspaces.com/keymapp/keymapp-latest.tar.gz -O /tmp/keymapp-download/keymapp.tar.gz
# Extract binary
tar -xf /tmp/keymapp-download/keymapp.tar.gz keymapp --directory /usr/bin
chmod 755 /usr/bin/keymapp
