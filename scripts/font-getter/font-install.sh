#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
set -oue pipefail

#
#  This script runs all the scripts in the font directory to download the fonts and
#  installs them in the correct directories.
#

# Helper functions.
yell() { echo "${0}: ${*}"; }
abort() { yell "${*}"; exit 0; }

# Ensure that a "scripts/" sub-directory exists for the "script category".
# Note that symlinks to other directories will be accepted by the `-d` check.
FONT_SCRIPTS_DIR="/tmp/scripts/fonts"
if [[ ! -d "${FONT_SCRIPTS_DIR}" ]]; then
    abort "Nothing to do, since \"${FONT_SCRIPTS_DIR}\" doesn't exist."
fi

# Generate a numerically sorted array of all scripts (or symlinks to scripts),
# without traversing into deeper subdirectories (to allow the user to store
# helper libraries in subfolders without accidental execution). Sorting is
# necessary for manually controlling the execution order via numeric prefixes.
mapfile -t buildscripts < <(find -L "${FONT_SCRIPTS_DIR}" -maxdepth 1 -type f -name "*.sh" | sort -n)

# Exit if there aren't any scripts in the directory.
if [[ ${#buildscripts[@]} -eq 0 ]]; then
    abort "Nothing to do, since \"${FONT_SCRIPTS_DIR}\" doesn't contain any scripts in its top-level directory."
fi

# Now simply execute all of the discovered scripts, and provide the name of the
# current "script category" as an argument, to match the behavior of "build.sh".
for script in "${buildscripts[@]}"; do
    echo "[fonts.sh] Installing font: ${script}"
    bash "$script"
done
