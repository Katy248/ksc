#!/bin/bash

execute() {
  if command -v nix-env ; then
    gum log --level info "Clearing home-manager generations older than 2 days"
    home-manager expire-generations -2days
    gum log --level info "Clearing nix generations older than 2 days"
    nix-env --delete-generations 2d
    gum log --level info "Collecting garbage in nix"
    nix-store --gc
  fi

  if command -v pacman ; then
    gum log --level info "Clearing pacman orphanes"
    pacman -Qqttd | pkexec pacman -Rsu --noconfirm - 
  fi

  if command -v flatpak ; then
    gum log --level info "Clearing unused flatpaks"
    flatpak uninstall --unused -y
  fi

  if command -v dnf ; then
    gum log --level info "Clearing dnf packages" 
    pkexec dnf autoremove -y
    gum log --level info "Clearing dnf cache" 
    pkexec dnf --verbose clean dbcache all
  fi

  if command -v docker ; then
    gum log --level info "Clearing docker"
    sudo docker container prune --force
    sudo docker image     prune --force
    sudo docker volume    prune --force
  fi
}

execute
