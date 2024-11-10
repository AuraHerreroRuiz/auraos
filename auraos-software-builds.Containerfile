ARG IMAGE_MAJOR_VERSION=41

# Download and patch JetBrainsMonoSlashed with Nerd Fonts
FROM fedora:${IMAGE_MAJOR_VERSION} as JetBrainsMonoSlashedNerdFont

COPY sources/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/JetBrainsMonoSlashedNerdFont.sh && \
        /tmp/build-scripts/JetBrainsMonoSlashedNerdFont.sh

#Build Headset Control
FROM fedora:${IMAGE_MAJOR_VERSION} as HeadsetControl-builder

COPY sources/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/build-headsetcontrol.sh && \
        /tmp/build-scripts/build-headsetcontrol.sh

# Build and install synaTudor drivers
FROM fedora:${IMAGE_MAJOR_VERSION} as synaTudor

COPY sources /tmp/sources

RUN chmod +x /tmp/sources/build-scripts/tudor.sh && \
        /tmp/sources/build-scripts/tudor.sh

FROM fedora:39 as bup-builder

COPY sources/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/build-bup.sh && \
        /tmp/build-scripts/build-bup.sh

#Build kup
FROM fedora:${IMAGE_MAJOR_VERSION} as kup-builder

COPY sources/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/build-kup.sh && \
        /tmp/build-scripts/build-kup.sh

# Finalize container build
FROM fedora:${IMAGE_MAJOR_VERSION}

RUN mkdir -p /artifacts/usr
RUN mkdir -p /artifacts/etc
RUN mkdir -p /artifacts/sbin
# Copy Bup and Kup artifacts from builder into image
COPY --from=kup-builder /tmp/kupbuilt/usr /artifacts/usr
COPY --from=kup-builder /tmp/kupbuilt/etc /artifacts/etc

COPY --from=bup-builder /tmp/bupbuilt/usr /artifacts/usr

# Copy fonts and licenses into image, then generate font cache
COPY --from=JetBrainsMonoSlashedNerdFont /tmp/usr /artifacts/usr

# Copy HeadsetControl artifacts from builder into image
COPY --from=HeadsetControl-builder /tmp/HeadsetControlBuilt/usr /artifacts/usr

# Copy fingerprint driver into image and install policy
COPY --from=synaTudor /tmp/libfrint-tod-build/usr /artifacts/usr
COPY --from=synaTudor /tmp/synatudor-build/sbin /artifacts/sbin
COPY --from=synaTudor /tmp/synatudor-build/usr /artifacts/usr
COPY --from=synaTudor /tmp/policiesout/usr /artifacts/usr
