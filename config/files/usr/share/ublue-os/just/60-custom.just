import '/usr/share/ublue-os/just/61-cryptenroll.just'
import '/usr/share/ublue-os/just/61-authentication.just'
import '/usr/share/ublue-os/just/61-theming.just'

# Install all flatpaks defined in recipe.yml
setup-flatpaks:
    #!/usr/bin/env bash
    echo 'Installing flatpaks from the ublue recipe ...'
    flatpaks=$(yq -- '.firstboot.flatpaks[]' "/usr/share/ublue-os/recipe.yml")
    for pkg in $flatpaks; do \
        echo "Installing: ${pkg}" && \
        flatpak install --user --noninteractive flathub $pkg; \
    done

opt-packages-symlink-restore:
    #!/usr/bin/env bash
    sudo ln -s "../../usr/lib/opt/enpass" "/var/opt/enpass"
    sudo ln -s "../../usr/lib/opt/vivaldi" "/var/opt/vivaldi"

#Useful when artifacts appear after graphic driver upgrades
vivaldi-remove-gpu-cache:
    find ~/.config/vivaldi/ -depth -type d -name GPUCache -exec rm -rf {} \;

#Pin a deployment. Use a number where 0 is the latest deployment, and increments the older the deployment.
pin-deployment deployment:
    sudo ostree admin pin "{{deployment}}"
#Unpin a deployment. Use a number where 0 is the latest deployment, and increments the older the deployment.
unpin-deployment deployment:
    sudo ostree admin pin -u "{{deployment}}"
