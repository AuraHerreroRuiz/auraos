#!/usr/bin/env bash
# Exit immediately upon error
set -oue pipefail
# Kup Build dependencies.
echo " -- Building Kup --"
mkdir /tmp/kupbuild
cd /tmp/kupbuild
echo "Installing dependencies"
dnf -y install git cmake extra-cmake-modules qt6-qtbase qt6-qtbase-devel kf6-kcmutils kf6-kcmutils-devel kf6-kcoreaddons kf6-kcoreaddons-devel kf6-kdbusaddons kf6-kdbusaddons-devel kf6-ki18n kf6-ki18n-devel kf6-kio kf6-kio-devel kf6-solid kf6-solid-devel kf6-kidletime kf6-kidletime-devel kf6-knotifications kf6-knotifications-devel kf6-kconfig kf6-kconfig-devel kf6-kjobwidgets kf6-kjobwidgets-devel kf6-plasma kf6-plasma-devel kf6-kxmlgui-devel plasma5support plasma5support-devel libgit2 libgit2-devel
#Clone kup repository
git clone 'https://invent.kde.org/system/kup.git'
cd kup
## Checkout last release
git checkout "$(git tag --sort=tag --list 'kup-[0-9]*' | tail -n 1)"
#Build Kup
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_WITH_QT6=ON -DQT_MAJOR_VERSION=6  ..
make
make install DESTDIR=/tmp/kupbuilt PREFIX='/usr'
