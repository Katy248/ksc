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

print_sudo_warn() {
  gum log \
    --level warn \
    --level.foreground "#fabd2f" \
    "Sudo will be used"
}

execute() {
  if program_exist paru; then
    paru -Syu --noconfirm
  elif program_exist pacman; then
    print_sudo_warn
    sudo pacman -Syu --noconfirm
  fi

  if program_exist dnf; then
    print_sudo_warn
    sudo dnf upgrade -y
  fi

  if program_exist nala; then
    print_sudo_warn
    sudo nala update
    sudo nala upgrade -y
  elif program_exist apt; then
    print_sudo_warn
    sudo apt update
    sudo apt upgrade -y
  fi

  if program_exist snap; then
    snap refresh
  fi

  if program_exist flatpak; then
    flatpak upgrade --force-remove --appstream -y
    flatpak upgrade --force-remove -y
  fi
}

execute
