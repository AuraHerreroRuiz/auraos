#!/usr/bin/env bash
set -oue pipefail

#Get binary from latest moar release
curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/walles/moar/releases/latest | jq --raw-output '.assets[] | select(.name | test("linux-386")).browser_download_url'
) -o /usr/bin/moar
