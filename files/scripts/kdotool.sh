#!/usr/bin/env bash
set -oue pipefail
mkdir -p /tmp/kdotool-download

wget https://github.com/jinliu/kdotool/releases/download/v0.2.2/kdotool-0.2.2-x86_64-unknown-linux-gnu.tar.gz -O /tmp/kdotool-download/kdotool.tar.gz
# Extract binary
mkdir -p /usr/bin
cd /usr/bin
tar -xf /tmp/kdotool-download/kdotool.tar.gz kdotool --group root --owner root
echo "85b04d6dede715c217c29c72bb0f81fc041e405cf9ea4dece859443a2bfd88b033626e66cb3337ba1696051b78fe2caa41ad90c86ac323f9175d0d8753f0631a  kdotool" | sha512sum -c
chmod 755 /usr/bin/kdotool

