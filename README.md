# AuraOS
AuraOS is my own custom fedora atomic image, built with software tailored to my needs.
## Installation
> [!Warning]
> This image is built using [an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To install, first install one existing [Atomic Fedora Desktop](https://fedoraproject.org/atomic-desktops) installation, and then rebase it to the latest build:

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
There is also a image with nvidia drivers:

```sh
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/auraherreroruiz/auraos-nvidia:latest
```

> [!TIP]
> This repository builds date tags as well, so if you want to rebase to a particular day's build:
> ```sh
> rpm-ostree rebase ostree-image-signed:docker://ghcr.io/auraherreroruiz/auraos:20230403
> ```


