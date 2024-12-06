#!/usr/bin/env bash
set -oue pipefail
mkdir -p /tmp/kdotool-download

wget https://github.com/jinliu/kdotool/releases/download/v0.2.2-pre/kdotool.tar.gz -O /tmp/kdotool-download/kdotool.tar.gz
# Extract binary
mkdir -p /usr/bin
cd /usr/bin
tar -xf /tmp/kdotool-download/kdotool.tar.gz kdotool --group root --owner root
echo "910497319a794266b3637f857318c53c32d99c08a8278d2d07dc86d41cbd93a5fe3640af4e54d8df1a97be14b3f93871d44b53e7b9c02721146d96e2f4dfe19c  kdotool" | sha512sum -c
chmod 755 /usr/bin/kdotool

