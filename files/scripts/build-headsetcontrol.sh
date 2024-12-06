#!/usr/bin/env bash
# Exit immediately upon error
set -oue pipefail
echo "-- Building Headset Control --"
mkdir /tmp/HeadsetControlBuild
# Installing dependencies.
echo "Installing Headset Control dependencies"
dnf -y install git coreutils cmake hidapi-devel g++
echo "Building BHeadset Control"
cd /tmp/HeadsetControlBuild
git clone 'https://github.com/Sapd/HeadsetControl.git'
cd HeadsetControl
# Checkout last release
git checkout "$(git tag --sort=taggerdate --list '[0-9]*' | tail -n 1)"
# Build Bup
mkdir build
cd build
cmake ..
make
make install DESTDIR=/tmp/HeadsetControlBuilt
mkdir -p /tmp/HeadsetControlBuilt/usr/bin
mkdir -p /tmp/HeadsetControlBuilt/usr/lib
mv /tmp/HeadsetControlBuilt/usr/local/bin /tmp/HeadsetControlBuilt/usr/
mv /tmp/HeadsetControlBuilt/usr/local/lib /tmp/HeadsetControlBuilt/usr/
rmdir /tmp/HeadsetControlBuilt/usr/local
