#!/usr/bin/env bash

set -oue pipefail

pipx ensurepath --global
pipx ensurepath
pipx install gcalcli --global
