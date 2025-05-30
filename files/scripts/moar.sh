#!/usr/bin/env bash
set -oue pipefail



#Get url of the binary from the latest releases, then download it.
curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
"$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/walles/moar/releases/latest | jq --raw-output ".assets[] | select(.name | test(\"linux-386\")).browser_download_url"
)" -o /usr/bin/moar;

#Set binary permissions accordingly
chmod 755 /usr/bin/moar
