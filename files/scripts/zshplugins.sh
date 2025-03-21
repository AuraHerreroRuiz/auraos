#!/usr/bin/env bash

set -oue pipefail

#Use this???
mkdir -p /usr/share/zsh-history-substring-search
cd /usr/share/zsh-history-substring-search
curl -O https://raw.githubusercontent.com/zsh-users/zsh-history-substring-search/master/zsh-history-substring-search.zsh

mkdir -p /usr/share/zsh-interactive-cd
cd /usr/share/zsh-interactive-cd
curl -O https://raw.githubusercontent.com/mrjohannchang/zsh-interactive-cd/master/zsh-interactive-cd.plugin.zsh

mkdir -p /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
curl -O https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

git clone https://github.com/b4b4r07/enhancd.git /usr/share/enhancd

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /usr/share/zsh-theme-powerlevel10k
