# Aura's own personalised uBlue images


## Installation

> **Warning**
> This is an experimental feature and should not be used in production, try it in a VM for a while!

To rebase an existing Silverblue/Kinoite installation to the latest build:

```sh
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/auraherreroruiz/auraos
```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```sh
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/auraherreroruiz/auraos:20230403
```

For the image with nvidia drivers:

```sh
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/auraherreroruiz/auraos-nvidia
```


## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/auraherreroruiz/auraos

If you're forking this repo, the uBlue website has [instructions](https://ublue.it/making-your-own/) for setting up signing properly.
