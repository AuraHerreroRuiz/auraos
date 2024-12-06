import '/usr/share/ublue-os/just/61-cryptenroll.just'
import '/usr/share/ublue-os/just/61-authentication.just'
import '/usr/share/ublue-os/just/61-theming.just'

opt-packages-symlink-restore:
    #!/usr/bin/env bash
    sudo ln -s "../../usr/lib/opt/enpass" "/var/opt/enpass"
    sudo ln -s "../../usr/lib/opt/vivaldi" "/var/opt/vivaldi"
    sudo ln -s "../../usr/lib/opt/pipx" "/var/opt/pipx"

#Useful when artifacts appear after graphic driver upgrades
vivaldi-remove-gpu-cache:
    find ~/.config/vivaldi/ -depth -type d -name GPUCache -exec rm -rf {} \;

#Pin a deployment. Use a number where 0 is the latest deployment, and increments the older the deployment.
pin-deployment deployment:
    sudo ostree admin pin "{{deployment}}"
#Unpin a deployment. Use a number where 0 is the latest deployment, and increments the older the deployment.
unpin-deployment deployment:
    sudo ostree admin pin -u "{{deployment}}"
