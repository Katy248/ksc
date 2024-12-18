#!/bin/bash

export GUM_SPIN_SHOW_ERROR=true
export GUM_SPIN_ALIGN="right"

execute() {

  gum log --level info "Starting packages clearing"

  if [ $(command -v nix-env) ]; then
    gum log --level debug "Nix found"
    gum spin --title "Clearing home-manager generations older than 0 min" -- \
      home-manager expire-generations -0min
    gum spin --title "Clearing nix generations" -- \
      nix-env --delete-generations +1
    gum spin --title "Collecting garbage in nix" -- \
      nix-store --gc
    gum log --level info "Nix packages cleared"
  fi

  if [ $(command -v pacman) ]; then
    gum log --level debug "Pacman found"
    gum log --level warn "Sudo will be used"
    gum spin --title "Clearing pacman orphanes" -- \
      "pacman -Qqttd | sudo pacman -Rsu --noconfirm -"
    gum log --level info "Pacman orphanes cleared"
  fi

  if [ $(command -v flatpak) ]; then
    gum log --level debug "Flatpak found"
    gum spin --title "Clearing unused flatpaks" -- \
      flatpak uninstall --unused -y
    gum log --level info "Flatpak packages cleared"
  fi

  if [ $(command -v dnf) ]; then
    gum log --level debug "Dnf found"
    gum spin --title "Clearing dnf packages" -- \
      pkexec dnf autoremove -y
    gum spin --title "Clearing dnf cache" -- \
      pkexec dnf --verbose clean dbcache all
    gum log --level info "Dnf unused packages and cache cleared"
  fi

  if [ $(command -v docker) ]; then
    gum log --level debug "Docker found"
    # gum log --level warn "Sudo will be used"
    gum spin --title "Clearing docker containers, images, volumes" -- \
      "
      pkexec docker container prune --force
      pkexec docker image prune --force
      pkexec docker volume prune --force
      "
    gum log --level info "Docker images, containers, volumes cleared"
  fi

  gum log --level info "Packages clearing done"
}

# if [[ $USER != "root" ]]; then
#   gum format "This script should be run only as root, so you should use \`sudo $0\` or \`pkexec $0\`
#   > Sit down punk..."
#   exit 1
# fi

execute
