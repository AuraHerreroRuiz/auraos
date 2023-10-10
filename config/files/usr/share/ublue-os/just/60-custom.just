# !include /usr/share/ublue-os/just/100-bling.just Commenting this as I don't use bling just files

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

opt-packages-symlink-restore:
  #!/usr/bin/env bash
  sudo ln -s "../../usr/lib/opt/enpass" "/var/opt/enpass"
  sudo ln -s "../../usr/lib/opt/vivaldi" "/var/opt/vivaldi"
