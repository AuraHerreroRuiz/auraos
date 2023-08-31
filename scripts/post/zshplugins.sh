#!/usr/bin/env bash

set -oue pipefail

#Use this???
mkdir -p /usr/share/zsh-history-substring-search
cd /usr/share/zsh-history-substring-search
wget https://raw.githubusercontent.com/zsh-users/zsh-history-substring-search/master/zsh-history-substring-search.zsh

mkdir -p /usr/share/zsh-sudo
cd /usr/share/zsh-sudo
wget wget https://raw.githubusercontent.com/zsh-users/zsh-history-substring-search/master/zsh-history-substring-search.zsh

git clone https://github.com/b4b4r07/enhancd.git /usr/share/enhancd
