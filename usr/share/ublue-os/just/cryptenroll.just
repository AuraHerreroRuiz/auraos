lukspath := `sudo blkid | grep 'crypto_LUKS' -m 1 | awk '{split($0,a,":"); print a[1];}'`
luksguid := `sudo blkid | grep 'crypto_LUKS' -m 1 | awk '{split($0,a,"UUID=\""); print a[2];}' | awk '{split($0,a,"\""); print a[1];}'`

#Enable unlocking the system encryption with a fido2 key
luks-enroll-fido:
    #!/usr/bin/env bash
    set -euxo pipefail
    sudo blkid | grep 'crypto_LUKS'
    sudo systemd-cryptenroll --fido2-device=auto --fido2-with-user-presence=yes --fido2-with-client-pin=yes {{lukspath}}
    rpm-ostree kargs --append=rd.luks.options={{luksguid}}=fido2-device=auto
    # Enable initramfs so the keyboard layout of the system is used to enter pins
    rpm-ostree initramfs --enable

#Enable unlocking the system encryption with a tpm2
luks-enroll-tpm2:
    #!/usr/bin/env bash
    set -euxo pipefail
    sudo blkid | grep 'crypto_LUKS'
    sudo systemd-cryptenroll --tpm2-device=auto --tpm2-with-pin=yes --tpm2-pcrs=7+14 {{lukspath}}
    rpm-ostree kargs --append=rd.luks.options={{luksguid}}=tpm2-device=auto
    # Enable initramfs so the keyboard layout of the system is used to enter pins
    rpm-ostree initramfs --enable

# Useful if the PCRs change and rebinding the tpm2 is needed, does not set kargs
luks-rebind-tpm2:
    #!/usr/bin/env bash
    set -euxo pipefail
    sudo blkid | grep 'crypto_LUKS'
    sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-with-pin=yes --tpm2-pcrs=7+14 {{lukspath}}
