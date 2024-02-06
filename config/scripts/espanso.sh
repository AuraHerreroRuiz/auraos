#!/usr/bin/env bash
set -oue pipefail

#Set tries of seeking version with a valid zip to 0
try=0

#Try downloading the zip from the most recent release, then go down the releases
while ! curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/espanso/espanso/releases | jq --raw-output ".[$try].assets[] | select(.name | test(\"Espanso-X11.AppImage\")) | select(.content_type | test(\"application/vnd.appimage\")).browser_download_url"
) -o /tmp/Espanso-X11.AppImage;

do
  ((try += 1))
  if ((try > 10)); then
    # We fail after 10 tries just in case
    exit 1
  fi
done

curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/espanso/espanso/releases | jq --raw-output ".[$try].assets[] | select(.name | test(\"Espanso-X11.AppImage.sha256\")) | select(.content_type | test(\"text/plain\")).browser_download_url"
) -o /tmp/espanso.sha256

#Checksum
sha256sum -c /tmp/espanso.sha256

#Copy to bin
cp /tmp/Espanso-X11.AppImage /usr/bin/espanso
chmod 755 espanso
