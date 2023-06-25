#!/usr/bin/env sh
set -oue pipefail
mkdir -p "/usr/etc/fonts/conf.d/"
ln -s "/usr/share/fontconfig/conf.avail/60-jetbrains-mono-fonts.conf" "/usr/etc/fonts/conf.d/60-jetbrains-mono-fonts.conf"
