#!/bin/bash

execute() {
  if command -v nix-env ; then
    home-manager expire-generations -2days
    nix-env --delete-generations 2d
    nix-store --gc
  fi

  if command -v pacman ; then
    pacman -Qqttd | sudo pacman -Rsu --noconfirm - 
  fi

  if command -v flatpak ; then
    flatpak uninstall --unused -y
  fi

  if command -v dnf ; then
    sudo dnf autoremove -y
    sudo dnf --verbose clean dbcache all
  fi

  if command -v docker ; then
    sudo docker container prune --force
    sudo docker image     prune --force
    sudo docker volume    prune --force
  fi
}

execute
