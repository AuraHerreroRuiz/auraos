#!/usr/bin/env bash

set -oue pipefail
#Get lsd artefact from latest GitHub build action
curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_GET_TOKEN"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
 $(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_GET_TOKEN"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/lsd-rs/lsd/actions/runs/$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_GET_TOKEN"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -d "status=success" \
  -d "branch=master" \
  -d "event=push" \
  -d "per-page=1" https://api.github.com/repos/lsd-rs/lsd/actions/runs | jq ".workflow_runs[0].id")/artifacts | jq '.artifacts[] | select(.name == "lsd-x86_64-unknown-linux-gnu").archive_download_url' --raw-output) -o /tmp/lsd.zip

#Extract lsd binary from zip file to /usr/bin and set permissions accordingly
cd /usr/bin
unzip /tmp/lsd.zip
chmod 755 lsd
