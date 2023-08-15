# Enroll fingerprint and enable authentication with it
fingerprint-auth:
    #!/usr/bin/env bash
    set -euxo pipefail
    fprintd-enroll
    sudo authselect enable-feature with-fingerprint

# Perfrom fido2/u2f and enable authentication with it
u2f-auth:
    #!/usr/bin/env bash
    set -euxo pipefail
    pamu2fcfg
    sudo authselect enable-feature with-pam-u2f
