#!/bin/bash

program_exist() {
  local program=$1
  if [ $(command -v "${program}") ]; then
    gum log \
      --level.foreground "#83a598" \
      --structured \
      --level debug \
      "${program} found" exec "'$(which ${program})'"
    return 0
  fi
  return 1
}

execute() {
  if program_exist pacman; then
    sudo pacman -Syu --noconfirm
  fi

  if program_exist dnf; then
    sudo dnf upgrade -y
  fi

  if program_exist nala; then
    sudo nala update
    sudo nala upgrade -y
  elif program_exist apt; then
    sudo apt update
    sudo apt upgrade -y
  fi

  if program_exist flatpak; then
    flatpak upgrade --force-remove --appstream -y
    flatpak upgrade --force-remove -y
  fi
}

execute
