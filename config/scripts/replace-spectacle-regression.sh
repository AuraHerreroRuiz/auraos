#!/usr/bin/env bash
set -oue pipefail
# Avoid regression https://bugs.kde.org/show_bug.cgi?id=473879
rpm-ostree override replace 'https://koji.fedoraproject.org/koji/buildinfo?buildID=2258866'
