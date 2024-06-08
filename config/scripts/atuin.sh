#!/usr/bin/env bash

set -oue pipefail

mkdir -p /tmp/atuin
cd /tmp/atuin
#Download atuin

#Set tries of seeking version with a valid targz to 0
try=0

#Try downloading the targz from the most recent release, then go down the releases
while ! curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/atuinsh/atuin/releases | jq --raw-output ".[$try].assets[] | select(.name | test(\"x86_64-unknown-linux-gnu.tar.gz\")).browser_download_url"
) -o /tmp/atuin/atuin.tar.gz;

do
  ((try += 1))
  if ((try > 10)); then
    # We fail after 10 tries just in case
    exit 1
  fi
done

#Get the zip name
zipname=$(basename -s '.tar.gz' $(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/atuinsh/atuin/releases | jq --raw-output ".[$try].assets[] | select(.name | test(\"x86_64-unknown-linux-gnu\")).name"))

mkdir -p /tmp/atuin/unzip

tar -xf /tmp/atuin/atuin.tar.gz --directory /tmp/atuin

cd "/tmp/atuin/$zipname"
#install
cp ./atuin /usr/bin/atuin
chmod 755 /usr/bin/atuin

mkdir -p /usr/share/bash-completion/completions
cp ./completions/atuin.bash /usr/share/bash-completion/completions/atuin
chmod 644 /usr/share/bash-completion/completions/atuin

mkdir -p /usr/share/fish/vendor_completions.d
cp ./completions/atuin.fish /usr/share/fish/vendor_completions.d/atuin
chmod 644 /usr/share/fish/vendor_completions.d/atuin

mkdir -p /usr/share/zsh/site-functions
cp ./completions/_atuin /usr/share/zsh/site-functions/_atuin
chmod 644 /usr/share/zsh/site-functions/_atuin

mkdir -p /usr/share/licenses/atuin
cp ./LICENSE /usr/share/licenses/atuin/LICENSE
chmod 644 /usr/share/licenses/atuin/LICENSE

mkdir -p /usr/share/doc/atuin
cp ./README.md /usr/share/licenses/atuin/README.md
chmod 644 /usr/share/licenses/atuin/README.md
