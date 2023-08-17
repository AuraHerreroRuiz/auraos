#Enable unlocking the system encryption with a fido2 key
luks-enroll-fido2:
    #!/usr/bin/env bash
    set -euxo pipefail
    # Verify a LUKS partition exists
    sudo blkid | grep 'crypto_LUKS'
    sudo systemd-cryptenroll --fido2-device=auto --fido2-with-user-presence=yes --fido2-with-client-pin=yes '`sudo blkid | grep 'crypto_LUKS' -m 1 | awk '{split($0,a,":"); print a[1];}'`'
    rpm-ostree kargs --append=rd.luks.options=fido2-device=auto
    rpm-ostree initramfs --enable --arg=--add --arg=fido2

#Enable unlocking the system encryption with a tpm2
luks-enroll-tpm2:
    #!/usr/bin/env bash
    set -euxo pipefail
    # Verify a LUKS partition exists
    sudo blkid | grep 'crypto_LUKS'
    sudo systemd-cryptenroll --tpm2-device=auto --tpm2-with-pin=yes --tpm2-pcrs=7+14 '`sudo blkid | grep 'crypto_LUKS' -m 1 | awk '{split($0,a,":"); print a[1];}'`'
    rpm-ostree kargs --append=rd.luks.options=tpm2-device=auto
    rpm-ostree initramfs --enable --arg=--add --arg=tpm2-tss

#Enable unlocking the system encryption with both a tpm2 and fido2 as a fallback
luks-enroll-tpm2-fido2:
    #!/usr/bin/env bash
    set -euxo pipefail
    sudo blkid | grep 'crypto_LUKS'
    sudo systemd-cryptenroll --fido2-device=auto --fido2-with-user-presence=yes --fido2-with-client-pin=yes '`sudo blkid | grep 'crypto_LUKS' -m 1 | awk '{split($0,a,":"); print a[1];}'`'sudo systemd-cryptenroll --fido2-device=auto --fido2-with-user-presence=yes --fido2-with-client-pin=yes '`sudo blkid | grep 'crypto_LUKS' -m 1 | awk '{split($0,a,":"); print a[1];}'`'
    sudo systemd-cryptenroll --tpm2-device=auto --tpm2-with-pin=yes --tpm2-pcrs=7+14 '`sudo blkid | grep 'crypto_LUKS' -m 1 | awk '{split($0,a,":"); print a[1];}'`'
    rpm-ostree kargs --append=rd.luks.options=tpm2-device=auto --append=rd.luks.options=fido2-device=auto
    rpm-ostree initramfs --enable --arg=--add --arg=tpm2-tss --arg=--add --arg=fido2

# Useful if the PCRs change and rebinding the tpm2 is needed, does not set kargs
luks-rebind-tpm2:
    #!/usr/bin/env bash
    set -euxo pipefail
    sudo blkid | grep 'crypto_LUKS'
    sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-with-pin=yes --tpm2-pcrs=7+14 {{lukspath}}
