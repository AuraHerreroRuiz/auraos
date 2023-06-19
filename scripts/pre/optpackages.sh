#!/usr/bin/env bash
set -oue pipefail

RECIPE_FILE="recipe.yml"
get_yaml_array() {
    mapfile -t "${1}" < <(yq -- "${2}" "${RECIPE_FILE}")
}

# Add repo files.
get_yaml_array optpackages '.rpm.optfix[]'
if [[ ${#optpackages[@]} -gt 0 ]]; then
    echo "-- Creating symlinks to fix packages that install to /opt --"
    mkdir -p "/tmp/fakeroot/var/opt"
    ln -s "/tmp/fakeroot/var/opt"  "/tmp/fakeroot/opt"
    for optpackage in "${optpackages[@]}"; do
        optpackage="${optpackage%\"}"
        optpackage="${optpackage#\"}"
        mkdir -p "/tmp/fakeroot/usr/lib/opt/${optpackage}"
        ln -s "../../usr/lib/opt/${optpackage}" "/tmp/fakeroot/var/opt/${optpackage}"
        echo "Created symlinks for ${optpackage}"
    done
    echo "---"
fi