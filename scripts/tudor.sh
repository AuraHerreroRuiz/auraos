#!/usr/bin/env bash

# Tell script process to exit if there are any errors.
set -oue pipefail

echo "-- Building fingerprint drivers --"
# Install dependencies
echo "Installing dependencies"
dnf -y install git clang libgusb libgusb-devel innoextract ninja-build meson gcc cmake openssl openssl-devel libusb1 libusb1-devel libcap libcap-devel libseccomp libseccomp-devel ghc-gio ghc-gio-devel dbus dbus-devel cairo cairo-devel cairo-gobject cairo-gobject-devel gobject-introspection gobject-introspection-devel nss nss-devel libgudev libgudev-devel gtk-doc valgrind valgrind-devel wget

echo "Building libfprint-tod"
cd /tmp
# Clone libfprint-tod repository
git clone 'https://gitlab.freedesktop.org/3v1n0/libfprint.git'
cd libfprint
git checkout tod
# Build synaTudor
meson build
cd build
# Install to /tmp to copy to final image
meson configure --prefix '/usr'
meson install --destdir '/tmp/libfrint-tod-build'
# Install to use as a dependency
meson install

echo "Building synaTudor"
cd /tmp
# Clone synaTudor repository
git clone 'https://github.com/Popax21/synaTudor.git'
cd synaTudor
# Build synaTudor
meson build
cd build
ninja
meson configure --prefix '/usr'
meson install --destdir '/tmp/synatudor-build'
