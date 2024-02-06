#!/usr/bin/env bash
# Exit immediately upon error
set -oue pipefail
echo "-- Building Espanso --"
echo "Installing dependencies"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /tmp/rustup-setup.sh
sh /tmp/rustup-setup.sh -y
export PATH="$PATH:/root/.cargo/bin"
dnf -y install git gcc libX11-devel libXtst-devel libxkbcommon-devel rust-libdbus-sys-devel wxBase3-devel wxGTK3-devel openssl-devel
cargo install --force cargo-make
echo "Building espanso"
# Clone espanso repository
cd /tmp
git clone 'https://github.com/espanso/espanso'
cd espanso
git checkout "$(git tag --sort=committerdate | grep -o 'v[0-9]*\.[0-9]*\.[0-9]*' | tail -n1)"
cargo make --profile release build-binary
mkdir -p /tmp/usr/bin
mkdir -p /tmp/usr/lib/systemd/user
mv target/release/espanso /tmp/usr/bin/espanso
mv espanso/src/res/linux/systemd.service /tmp/usr/lib/systemd/user/espanso.service

