#!/usr/bin/env bash
# Exit immediately upon error
set -oue pipefail
echo "-- Building Kup --"
# General Build dependencies
echo "Installing general dependencies"
dnf -y install git
# Bup Build dependencies.
echo "Installing Bup dependencies"
dnf -y install python3-devtools python-devel python3-pyxattr python3-pytest make gcc acl attr rsync
echo "Building Bup"
#Build bup
mkdir /tmp/bupbuild
cd /tmp/bupbuild
git clone https://github.com/bup/bup
git checkout 0.33
cd bup
make long-check
make install DESTDIR=/tmp/bup PREFIX='/usr'
# Kup Build dependencies.
mkdir /tmp/kupbuild
cd /tmp/kupbuild
echo "Installing Kup dependencies" 
dnf -y install cmake extra-cmake-modules qt5-qtbase qt5-qtbase-devel kf5-kcoreaddons kf5-kcoreaddons-devel kf5-kdbusaddons kf5-kdbusaddons-devel kf5-ki18n kf5-ki18n-devel kf5-kio kf5-kio-devel kf5-solid kf5-solid-devel kf5-kidletime kf5-kidletime-devel kf5-knotifications kf5-knotifications-devel kf5-kconfig kf5-kconfig-devel kf5-kjobwidgets kf5-kjobwidgets-devel kf5-plasma kf5-plasma-devel libgit2 libgit2-devel
echo "Building Kup"
git clone https://invent.kde.org/system/kup.git
cd kup
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=release ..
make
make install DESTDIR=/tmp/kup PREFIX='/usr'
