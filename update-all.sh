#!/bin/bash

execute() {
  if command -v pacman ; then
    sudo pacman -Syu --noconfirm 
  fi
  
  if command -v dnf ; then
    sudo dnf upgrade -y
  fi

  if command -v nala ; then
    sudo nala update
    sudo nala upgrade -y
  elif command -v apt ; then
    sudo apt update
    sudo apt upgrade -y
  fi

  if command -v flatpak ; then
    flatpak upgrade --force-remove --appstream -y
    flatpak upgrade --force-remove -y
  fi
}

execute
