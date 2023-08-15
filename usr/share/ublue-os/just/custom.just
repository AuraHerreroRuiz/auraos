# !include /usr/share/ublue-os/just/bling.just Commenting because this file doesn't exist
!include /usr/share/ublue-os/just/cryptenroll.just
!include /usr/share/ublue-os/just/authentication.just
!include /usr/share/ublue-os/just/theming.just

# Install all flatpaks defined in recipe.yml
setup-flatpaks:
  #!/usr/bin/env bash
  echo 'Installing flatpaks from the ublue recipe ...'
  flatpaks=$(yq -- '.firstboot.flatpaks[]' "/usr/share/ublue-os/recipe.yml")
  for pkg in $flatpaks; do \
      echo "Installing: ${pkg}" && \
      flatpak install --user --noninteractive flathub $pkg; \
  done

# Include some of your custom scripts here!
