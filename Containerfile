# This is the Containerfile for your custom image.

# It takes in the recipe, version, and base image as arguments,
# all of which are provided by build.yml when doing builds
# in the cloud. The ARGs have default values, but changing those
# does nothing if the image is built in the cloud.

ARG FEDORA_MAJOR_VERSION=38
# Warning: changing this might not do anything for you. Read comment above.
ARG BASE_IMAGE_URL=ghcr.io/ublue-os/silverblue-main


#First stage of image build
FROM ${BASE_IMAGE_URL}:${FEDORA_MAJOR_VERSION} as first-stage

# The default recipe set to the recipe's default filename
# so that `podman build` should just work for many people.
ARG RECIPE=./recipe.yml

# The default image registry to write to policy.json and cosign.yaml
ARG IMAGE_REGISTRY=ghcr.io/ublue-os

# Copy static configurations and component files.
# Warning: If you want to place anything in "/etc" of the final image, you MUST
# place them in "./usr/etc" in your repo, so that they're written to "/usr/etc"
# on the final system. That is the proper directory for "system" configuration
# templates on immutable Fedora distros, whereas the normal "/etc" is ONLY meant
# for manual overrides and editing by the machine's admin AFTER installation!
# See issue #28 (https://github.com/ublue-os/startingpoint/issues/28).
COPY usr /usr

# Copy public key
COPY cosign.pub /usr/share/ublue-os/cosign.pub

# Copy the recipe that we're building.
COPY ${RECIPE} /usr/share/ublue-os/recipe.yml

# "yq" used in build.sh and the "setup-flatpaks" just-action to read recipe.yml.
# Copied from the official container image since it's not available as an RPM.
COPY --from=docker.io/mikefarah/yq /usr/bin/yq /usr/bin/yq

# Copy the build script and all custom scripts.
COPY scripts /tmp/scripts

# ARG for the github token for getting artifacts
ARG GH_GET_TOKEN

# Run the build script and clean up temp files.
RUN chmod +x /tmp/scripts/build.sh && \
        /tmp/scripts/build.sh && \
        rm -rf /tmp/* /var/*

# Install synaTudor drivers
FROM fedora:${FEDORA_MAJOR_VERSION} as synaTudor

COPY scripts /tmp/scripts

RUN chmod +x /tmp/scripts/tudor.sh && \
        /tmp/scripts/tudor.sh

# Download and patch fonts
FROM fedora:${FEDORA_MAJOR_VERSION} as font-getter

COPY scripts/font-getter /tmp/scripts

RUN chmod +x /tmp/scripts/font-install.sh && \
        /tmp/scripts/font-install.sh

#Build kup
FROM fedora:${FEDORA_MAJOR_VERSION} as kup-builder

COPY scripts /tmp/scripts

RUN chmod +x /tmp/scripts/build-kup.sh && \
        /tmp/scripts/build-kup.sh

# Copy kup build and finalize container build.
FROM first-stage

# Copy Bup and Kup artifacts from builder into image
COPY --from=kup-builder /tmp/kupbuilt/usr /usr
COPY --from=kup-builder /tmp/kupbuilt/etc /usr/etc
COPY --from=kup-builder /tmp/bupbuilt/usr /usr

# Copy fonts and licenses into image, then generate font cache
COPY --from=font-getter /tmp/usr /usr
RUN fc-cache -fv

# Copy fingerprint driver into image
COPY --from=synaTudor /tmp/libfrint-tod-build/usr /usr
COPY --from=synaTudor /tmp/synatudor-build/sbin /sbin
COPY --from=synaTudor /tmp/synatudor-build/usr /usr
#Remove SELinux restrictions for the fingerprint driver
RUN chcon -t unconfined_exec_t /usr/sbin/tudor/tudor_host_launcher

#Commit changes
RUN ostree container commit
