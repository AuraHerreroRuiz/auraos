#!/usr/bin/env bash
set -oue pipefail

#Download font files
mkdir -p /tmp/usr/share/fonts/atkinson-hyperlegible
curl -GL https://github.com/google/fonts/raw/main/ofl/atkinsonhyperlegible/AtkinsonHyperlegible-Regular.ttf -o /tmp/usr/share/fonts/atkinson-hyperlegible/AtkinsonHyperlegible-Regular.ttf
curl -GL https://github.com/google/fonts/raw/main/ofl/atkinsonhyperlegible/AtkinsonHyperlegible-Italic.ttf -o /tmp/usr/share/fonts/atkinson-hyperlegible/AtkinsonHyperlegible-Italic.ttf
curl -GL https://github.com/google/fonts/raw/main/ofl/atkinsonhyperlegible/AtkinsonHyperlegible-Bold.ttf -o /tmp/usr/share/fonts/atkinson-hyperlegible/AtkinsonHyperlegible-Bold.ttf
curl -GL https://github.com/google/fonts/raw/main/ofl/atkinsonhyperlegible/AtkinsonHyperlegible-BoldItalic.ttf -o /tmp/usr/share/fonts/atkinson-hyperlegible/AtkinsonHyperlegible-BoldItalic.ttf

#Download font license
mkdir -p /tmp/usr/share/licenses/atkinson-hyperlegible
curl -GL https://github.com/google/fonts/raw/main/ofl/atkinsonhyperlegible/OFL.txt -o /tmp/usr/share/licenses/atkinson-hyperlegible/OFL.txt
