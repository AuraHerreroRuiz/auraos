#!/usr/bin/env bash

set -oe pipefail

sudo pipx ensurepath --global
pipx ensurepath
pipx install gcalcli
