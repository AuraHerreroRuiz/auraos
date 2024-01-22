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
  https://api.github.com/repos/k0kubun/xremap/releases | jq --raw-output ".[$try].assets[] | select(.name | test(\"linux-x86_64-kde\")).browser_download_url"
) -o /tmp/xremap.zip;

do
  ((try += 1))
  if ((try > 10)); then
    # We fail after 10 tries just in case
    exit 1
  fi
done

#Extract xremap binary from zip file to /usr/bin and set permissions accordingly
cd /usr/bin
unzip /tmp/xremap.zip
chmod 755 xremap
