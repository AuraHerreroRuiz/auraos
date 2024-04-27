#!/usr/bin/env bash
# Exit immediately upon error
set -oue pipefail
echo "-- Building Kup --"
# General build dependencies
echo "Installing general dependencies"
dnf -y install git
# Bup Build dependencies.
echo "Installing Bup dependencies"
dnf -y install python3-devtools python-devel python3-pyxattr python3-pytest make gcc acl attr rsync diffutils kmod python3-distutils-extra pkg-config  glibc glibc-devel  python3-pytest-xdist par2cmdline libacl libacl-devel
echo "Building Bup"
mkdir /tmp/bupbuild
cd /tmp/bupbuild
#Clone Bup repository
git clone 'https://github.com/bup/bup.git'
cd bup
# Checkout last release
git checkout "$(git tag --sort=tag --list '[0-9]*' | tail -n 1)"
# Build Bup
make long-check
make install DESTDIR=/tmp/bupbuilt PREFIX='/usr'
