#!/usr/bin/env bash
set -oue pipefail
# Avoid regression https://bugs.kde.org/show_bug.cgi?id=473879

curl 'https://kojipkgs.fedoraproject.org//packages/spectacle/23.04.3/2.fc38/x86_64/spectacle-23.04.3-2.fc38.x86_64.rpm' --output /tmp/spectacle.rpm
rpm-ostree override replace /tmp/spectacle.rpm
