#!/usr/bin/env bash
set -oue pipefail

#Set tries of seeking version with an executable to 0
try=0

#Try downloading the executable from the most recent release, then go down the releases
while ! curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/walles/moar/releases | jq --raw-output ".[$try].assets[] | select(.name | test(\"linux-386\")).browser_download_url"
) -o /usr/bin/moar;

do
  ((try += 1))
  if ((try > 10)); then
    # We fail after 10 tries just in case
    exit 1
  fi
done

#Set binary permissions accordingly
chmod 755 /usr/bin/moar
