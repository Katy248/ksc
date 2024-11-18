#!/bin/bash

add_syncthing_device() {
  local id=$1
  local name=$2
  echo "Adding device with name '${name}', id '${id}'"
  syncthing cli config devices add --device-id "${id}" --name "${name}"
}

pkexec dnf install -y syncthing flatpak

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub md.obsidian.Obsidian

systemctl enable --now --user syncthing

add_syncthing_device "BBQC5NQ-IRUMWLU-FAEHF3I-ZAY5XNI-VKUR53G-HJ3FCBO-PPI75YZ-5D2H3AU" "Антон Петров - ПК"
add_syncthing_device "MTNYZJM-ZWLEJMX-NQKQP3U-P4TQENH-KP5EXXX-M4SXLGK-ZMG52QF-TKHJVQL" "Кристина Орлова - Ноутбук"
