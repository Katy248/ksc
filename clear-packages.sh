#!/bin/bash

execute() {
  if command -v nix-env ; then
    home-manager expire-generations -2days
    nix-env --delete-generations 2d
    nix-store --gc 
  fi

  if command -v flatpak ; then 
    flatpak uninstall --unused -y
  fi

  if command -v dnf ; then 
    sudo dnfo --verbose clean dbcache all
  fi
}

execute
