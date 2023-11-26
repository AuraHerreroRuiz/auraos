# This is the Containerfile for your custom image.

# Instead of adding RUN statements here, you should consider creating a script
# in `config/scripts/`. Read more in `modules/script/README.md`

# This Containerfile takes in the recipe, version, and base image as arguments,
# all of which are provided by build.yml when doing builds
# in the cloud. The ARGs have default values, but changing those
# does nothing if the image is built in the cloud.

# !! Warning: changing these might not do anything for you. Read comment above.
ARG IMAGE_MAJOR_VERSION=39
ARG BASE_IMAGE_URL=ghcr.io/ublue-os/silverblue-main


#First stage of image build
FROM ${BASE_IMAGE_URL}:${IMAGE_MAJOR_VERSION} as first-stage

# The default recipe is set to the recipe's default filename
# so that `podman build` should just work for most people.
ARG RECIPE=recipe.yml
# The default image registry to write to policy.json and cosign.yaml
ARG IMAGE_REGISTRY=ghcr.io/ublue-os
ARG IMAGE_MAJOR_VERSION="${IMAGE_MAJOR_VERSION:-39}"
# ARG for the github token for getting artifacts
ARG GH_GET_TOKEN

COPY cosign.pub /usr/share/ublue-os/cosign.pub

# Copy the bling from ublue-os/bling into tmp, to be installed later by the bling module
# Feel free to remove these lines if you want to speed up image builds and don't want any bling
COPY --from=ghcr.io/ublue-os/bling:latest /rpms /tmp/bling/rpms
COPY --from=ghcr.io/ublue-os/bling:latest /files /tmp/bling/files

# Copy build scripts & configuration
COPY build.sh /tmp/build.sh
COPY config /tmp/config/

# Copy modules
# The default modules are inside ublue-os/bling
COPY --from=ghcr.io/ublue-os/bling:latest /modules /tmp/modules/
# Custom modules overwrite defaults
COPY modules /tmp/modules/

# `yq` is used for parsing the yaml configuration
# It is copied from the official container image since it's not available as an RPM.
COPY --from=docker.io/mikefarah/yq /usr/bin/yq /usr/bin/yq

#Kmods
COPY --from=ghcr.io/ublue-os/akmods:main-"${IMAGE_MAJOR_VERSION}" /rpms/ /tmp/rpms
COPY sources/build-scripts /tmp/build-scripts
chmod +x /tmp/build-scripts/kmods.sh && \
        /tmp/build-scripts/kmods.sh

# Run the build script, then clean up temp files and finalize container build.
RUN chmod +x /tmp/build.sh && /tmp/build.sh && \
        rm -rf /tmp/* /var/*

#Build lightly-qt
FROM fedora:${IMAGE_MAJOR_VERSION} as lightly-qt-builder

COPY sources/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/lightly-qt.sh && \
        /tmp/build-scripts/lightly-qt.sh

# Download and patch JetBrainsMonoSlashed with Nerd Fonts
FROM fedora:${IMAGE_MAJOR_VERSION} as JetBrainsMonoSlashedNerdFont

COPY sources/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/JetBrainsMonoSlashedNerdFont.sh && \
        /tmp/build-scripts/JetBrainsMonoSlashedNerdFont.sh

# Build and install synaTudor drivers
FROM fedora:${IMAGE_MAJOR_VERSION} as synaTudor

COPY sources /tmp/sources

RUN chmod +x /tmp/sources/build-scripts/tudor.sh && \
        /tmp/sources/build-scripts/tudor.sh

#Build kup
FROM fedora:${IMAGE_MAJOR_VERSION} as kup-builder

COPY sources/build-scripts /tmp/build-scripts

RUN chmod +x /tmp/build-scripts/build-kup.sh && \
        /tmp/build-scripts/build-kup.sh


# Finalize container build
FROM first-stage

# Copy Bup and Kup artifacts from builder into image
COPY --from=kup-builder /tmp/kupbuilt/usr /usr
COPY --from=kup-builder /tmp/kupbuilt/etc /usr/etc
COPY --from=kup-builder /tmp/bupbuilt/usr /usr

# Copy fonts and licenses into image, then generate font cache
COPY --from=JetBrainsMonoSlashedNerdFont /tmp/usr /usr
RUN fc-cache -fv

# Copy fingerprint driver into image and install policy
COPY --from=synaTudor /tmp/libfrint-tod-build/usr /usr
COPY --from=synaTudor /tmp/synatudor-build/sbin /sbin
COPY --from=synaTudor /tmp/synatudor-build/usr /usr
COPY --from=synaTudor /tmp/policiesout/usr /usr
RUN semodule -n -s targeted -X 200 -i /usr/share/selinux/packages/targeted/fprintd-tudor.pp

# Copy lightly-qt into image
COPY --from=lightly-qt-builder /tmp/lightly-qt-built/usr /usr

#Commit changes
RUN ostree container commit
