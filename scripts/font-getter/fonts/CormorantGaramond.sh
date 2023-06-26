#!/usr/bin/env bash
set -oue pipefail

#Download font files
mkdir -p /tmp/usr/share/fonts/cormorant-garamond
curl -GL https://github.com/google/fonts/raw/main/ofl/cormorantgaramond/CormorantGaramond-Light.ttf -o /tmp/usr/share/fonts/cormorant-garamond/CormorantGaramond-Light.ttf
curl -GL https://github.com/google/fonts/raw/main/ofl/cormorantgaramond/CormorantGaramond-LightItalic.ttf -o /tmp/usr/share/fonts/cormorant-garamond/CormorantGaramond-LightItalic.ttf
curl -GL https://github.com/google/fonts/raw/main/ofl/cormorantgaramond/CormorantGaramond-Regular.ttf -o /tmp/usr/share/fonts/cormorant-garamond/CormorantGaramond-Regular.ttf
curl -GL https://github.com/google/fonts/raw/main/ofl/cormorantgaramond/CormorantGaramond-Italic.ttf -o /tmp/usr/share/fonts/cormorant-garamond/CormorantGaramond-Italic.ttf
curl -GL https://github.com/google/fonts/raw/main/ofl/cormorantgaramond/CormorantGaramond-Medium.ttf -o /tmp/usr/share/fonts/cormorant-garamond/CormorantGaramond-Medium.ttf
curl -GL https://github.com/google/fonts/raw/main/ofl/cormorantgaramond/CormorantGaramond-MediumItalic.ttf -o /tmp/usr/share/fonts/cormorant-garamond/CormorantGaramond-MediumItalic.ttf
curl -GL https://github.com/google/fonts/raw/main/ofl/cormorantgaramond/CormorantGaramond-SemiBold.ttf -o /tmp/usr/share/fonts/cormorant-garamond/CormorantGaramond-SemiBold.ttf.ttf
curl -GL https://github.com/google/fonts/raw/main/ofl/cormorantgaramond/CormorantGaramond-SemiBoldItalic.ttf -o /tmp/usr/share/fonts/cormorant-garamond/CormorantGaramond-SemiBoldItalic.ttf
curl -GL https://github.com/google/fonts/raw/main/ofl/cormorantgaramond/CormorantGaramond-Bold.ttf -o /tmp/usr/share/fonts/cormorant-garamond/CormorantGaramond-Bold.ttf
curl -GL https://github.com/google/fonts/raw/main/ofl/cormorantgaramond/CormorantGaramond-BoldItalic.ttf -o /tmp/usr/share/fonts/cormorant-garamond/CormorantGaramond-BoldItalic.ttf

#Download font license
mkdir -p /tmp/usr/share/licenses/cormorant-garamond
curl -GL https://github.com/google/fonts/raw/main/ofl/cormorantgaramond/OFL.txt -o /tmp/usr/share/licenses/cormorant-garamond/OFL.txt
