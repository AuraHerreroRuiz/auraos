#!/usr/bin/env bash

# Download binary
set -oue pipefail
mkdir -p /tmp/keymapp-download
# From https://www.zsa.io/flash
wget https://oryx.nyc3.cdn.digitaloceanspaces.com/keymapp/keymapp-latest.tar.gz -O /tmp/keymapp-download/keymapp.tar.gz
# Extract binary
mkdir -p /usr/bin
cd /usr/bin
tar -xf /tmp/keymapp-download/keymapp.tar.gz keymapp --group root --owner root
chmod 755 /usr/bin/keymapp
