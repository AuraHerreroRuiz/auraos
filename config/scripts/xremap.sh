#!/usr/bin/env bash
set -oue pipefail

#Get lastest binary from latest xremap release
curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/k0kubun/xremap/releases/latest | jq --raw-output '.assets[] | select(.name | test("linux-x86_64-kde")).browser_download_url'
) -o /tmp/xremap.zip

#Extract xremap binary from zip file to /usr/bin and set permissions accordingly
cd /usr/bin
unzip /tmp/xremap.zip
chmod 755 xremap
