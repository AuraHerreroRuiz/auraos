# Aura's own personalised uBlue images

## Installation

> **Warning**
> This is an experimental feature and should not be used in production, try it in a VM for a while!

To rebase an existing Silverblue/Kinoite installation to the latest build:

- First rebase to the image unsigned, to get the proper signing keys and policies installed:

  ```sh
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/auraherreroruiz/auraos:latest
  ```

- Reboot to complete the rebase:

  ```sh
  systemctl reboot
  ```

- Then rebase to the signed image, like so:

  ```sh
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/auraherreroruiz/auraos:latest
  ```
  
- Reboot again to complete the installation

  ```sh
  systemctl reboot
  ```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```sh
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ublue-os/startingpoint:20230403
```

For the image with nvidia drivers:

```sh
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/auraherreroruiz/auraos-nvidia
```
