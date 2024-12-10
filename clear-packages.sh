#!/bin/bash

execute() {

  gum log --level info "Starting packages clearing"

  if [ $(command -v nix-env) ]; then
    gum spin --title "Clearing home-manager generations older than 0 min" -- \
      home-manager expire-generations -0min
    gum spin --title "Clearing nix generations" -- \
      nix-env --delete-generations +1
    gum spin --title "Collecting garbage in nix" -- \
      nix-store --gc
  fi

  if [ $(command -v pacman) ]; then
    gum log --level info "Pacman found"
    gum log --level warn "Sudo will be used"
    gum spin --title "Clearing pacman orphanes" -- \
      "pacman -Qqttd | sudo pacman -Rsu --noconfirm -"
  fi

  if [ $(command -v flatpak) ]; then
    gum spin --title "Clearing unused flatpaks" -- \
      flatpak uninstall --unused -y
  fi

  if [ $(command -v dnf) ]; then
    gum spin --title "Clearing dnf packages" -- \
      pkexec dnf autoremove -y
    gum spin --title "Clearing dnf cache" -- \
      pkexec dnf --verbose clean dbcache all
  fi

  if [ $(command -v docker) ]; then
    gum log --level info "Docker found"
    gum log --level warn "Sudo will be used"
    gum spin --title "Clearing docker containers" -- \
      sudo docker container prune --force
    gum spin --title "Clearing docker images" -- \
      sudo docker image prune --force
    gum spin --title "Clearing docker volumes" -- \
      sudo docker volume prune --force
  fi

  gum log --level info "packages clearing done"
}

if [[ $USER != "root" ]]; then
  gum format "This script should be run only as root, so you should use \`sudo $0\` or \`pkexec $0\`
  > Sit down punk..."
  exit 1
fi

execute
