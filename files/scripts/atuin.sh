#!/usr/bin/env bash

set -oue pipefail

mkdir -p /tmp/atuin
cd /tmp/atuin
#Download atuin

#Set tries of seeking version with a valid targz to 0


#Try downloading the targz from the most recent release, then go down the releases
curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
"$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/atuinsh/atuin/releases/latest | jq --raw-output ".assets[] | select(.name | test(\"x86_64-unknown-linux-gnu.tar.gz$\")).browser_download_url"
)" -o /tmp/atuin/atuin.tar.gz;


#Get the zip name
zipname=$(basename -s '.tar.gz' "$(curl -GL \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/atuinsh/atuin/releases/latest | jq --raw-output ".assets[] | select(.name | test(\"x86_64-unknown-linux-gnu.tar.gz$\")).name")")

mkdir -p /tmp/atuin/unzip

tar -xf /tmp/atuin/atuin.tar.gz --directory /tmp/atuin

cd "/tmp/atuin/$zipname"
#install
cp ./atuin /usr/bin/atuin
chmod 755 /usr/bin/atuin

mkdir -p /usr/share/licenses/atuin
cp ./LICENSE /usr/share/licenses/atuin/LICENSE
chmod 644 /usr/share/licenses/atuin/LICENSE

mkdir -p /usr/share/doc/atuin
cp ./README.md /usr/share/licenses/atuin/README.md
chmod 644 /usr/share/licenses/atuin/README.md

# Shell completions
mkdir -p /usr/share/bash-completion/completions
/usr/bin/atuin gen-completions --shell bash > /usr/share/bash-completion/completions/atuin
chmod 644 /usr/share/bash-completion/completions/atuin

mkdir -p /usr/share/fish/vendor_completions.d
/usr/bin/atuin gen-completions --shell fish > /usr/share/fish/vendor_completions.d/atuin
chmod 644 /usr/share/fish/vendor_completions.d/atuin

mkdir -p /usr/share/zsh/site-functions
/usr/bin/atuin gen-completions --shell zsh > /usr/share/zsh/site-functions/_atuin
chmod 644 /usr/share/zsh/site-functions/_atuin
