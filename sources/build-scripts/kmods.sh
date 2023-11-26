#!/usr/bin/env bash
set -oue pipefail
echo "-- Installing Kmods --"

for REPO in $(rpm -ql ublue-os-akmods-addons|grep ^"/etc"|grep repo$); do
    echo "akmods: enable default entry: ${REPO}"
    sed -i '0,/enabled=0/{s/enabled=0/enabled=1/}' "${REPO}"
done

rpm-ostree install --idempotent \
    /tmp/rpms/kmods/*v4l2loopback*.rpm \
    /tmp/rpms/kmods/*openrgb*.rpm
#    /tmp/rpms/kmods/*xpadneo*.rpm

