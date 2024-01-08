# Enroll fingerprint and enable authentication with it
fingerprint-auth:
    #!/usr/bin/env bash
    set -euo pipefail
    fprintd-enroll
    sudo authselect enable-feature with-fingerprint

fingerprint-auth-remove:
    #!/usr/bin/env bash
    set -euo pipefail
    sudo authselect enable-feature with-fingerprint

# Perfrom fido2/u2f and enable authentication with it
u2f-auth:
    #!/usr/bin/env bash
    set -euo pipefail
    pamu2fcfg | tee -p .config/Yubico/u2f_keys
    sudo authselect enable-feature with-pam-u2f
    # pamu2f doesnt work well with sddm
    sudo cp /etc/pam.d/password-auth /etc/pam.d/password-auth-no-u2f
    sudo sed -i '/.*pam_u2f.*/d' /etc/pam.d/password-auth-no-u2f
    sudo sed -i -E 's/auth( *)substack( *)password-auth/auth        substack        password-auth-no-u2f/g' /etc/pam.d/sddm

u2f-auth-remove:
    #!/usr/bin/env bash
    set -euo pipefail
    sudo authselect disable-feature with-pam-u2f
    # Fix up sddm changes
    sudo rm -f /etc/pam.d/password-auth-no-u2f
    sudo sed -iE 's/auth( *)substack( *)password-auth-no-u2f/auth        substack        password-auth/g' /etc/pam.d/sddm

ssh-agent key:
    systemctl --user enable --now ssh-agent.socket
    ssh-add {{ key }}
