#!/usr/bin/env bash
set -oue pipefail

# Install dependencies
dnf -y install fontforge python3-configargparse python3-setuptools glibc-gconv-extra jq unzip

# Download font
curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/sharpjs/JetBrainsMonoSlashed/releases/latest | jq  --raw-output '.assets[0].browser_download_url') -o /tmp/JetBrainsMonoSlashed.zip

# Download Nerd Fonts font-patcher
mkdir -p /tmp/fontpatcher
cd /tmp/fontpatcher
curl -GL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip -o /tmp/fontpatcher/fontpatcher.zip
unzip /tmp/fontpatcher/fontpatcher.zip
mkdir -p /tmp/jetbrains-mono-slashed /tmp/usr/share/jetbrains-mono-slashed-nerd-font
cd /tmp/jetbrains-mono-slashed
#Unzip original font
unzip /tmp/JetBrainsMonoSlashed.zip JetBrainsMonoSlashed-Thin.otf JetBrainsMonoSlashed-ExtraLight.otf JetBrainsMonoSlashed-Light.otf JetBrainsMonoSlashed-Regular.otf JetBrainsMonoSlashed-Medium.otf JetBrainsMonoSlashed-SemiBold.otf JetBrainsMonoSlashed-Bold.otf JetBrainsMonoSlashed-ExtraBold.otf JetBrainsMonoSlashed-ThinItalic.otf JetBrainsMonoSlashed-ExtraLightItalic.otf JetBrainsMonoSlashed-LightItalic.otf JetBrainsMonoSlashed-Italic.otf JetBrainsMonoSlashed-MediumItalic.otf JetBrainsMonoSlashed-SemiBoldItalic.otf JetBrainsMonoSlashed-BoldItalic.otf JetBrainsMonoSlashed-ExtraBoldItalic.otf

#Patch fonts
for font in /tmp/jetbrains-mono-slashed/*.otf;
do [ -f "$font" ] && fontforge -script /tmp/fontpatcher/font-patcher -qc -ext otf -out /tmp/usr/share/fonts/jetbrains-mono-slashed-nerd-font "$font";
done

#Download font license
mkdir -p /tmp/usr/share/licenses/jetbrains-mono-slashed-nerd-font
curl -GL https://github.com/JetBrains/JetBrainsMono/raw/master/OFL.txt -o /tmp/usr/share/licenses/jetbrains-mono-slashed-nerd-font/OFL.txt

