#!/usr/bin/env bash
# Exit immediately upon error
set -oue pipefail
echo "-- Building Lightly-qt --"
echo "Installing general dependencies"
dnf -y install git cmake extra-cmake-modules "cmake(Qt5Core)" "cmake(Qt5Gui)" "cmake(Qt5DBus)" "cmake(Qt5X11Extras)" "cmake(KF5GuiAddons)" "cmake(KF5WindowSystem)" "cmake(KF5I18n)" "cmake(KDecoration2)" "cmake(KF5CoreAddons)" "cmake(KF5ConfigWidgets)" "cmake(Qt5UiTools)" "cmake(KF5GlobalAccel)" "cmake(KF5IconThemes)" kwin-devel libepoxy-devel "cmake(KF5Init)" "cmake(KF5Crash)" "cmake(KF5KIO)" "cmake(KF5Notifications)" kf5-kpackage-devel
echo "Building Lightly-qt"
cd /tmp
git clone --single-branch --depth=1 https://github.com/Luwx/Lightly.git
cd Lightly
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_TESTING=OFF ..
make
make install DESTDIR=/tmp/lightly-qt-built PREFIX='/usr'
