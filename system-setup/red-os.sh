#!/bin/bash
source ./functions.sh

flatpak_pkgs=('md.obsidian.Obsidian' 'io.github.finefindus.Hieroglyphic' 'org.telegram.desktop')

rpm_pkgs=(
    'zsh'
    'neovim'
    'stow'
    'git'
)

disable_selinux

sudo dnf upgrade -y

## Setup flatpak
install_package flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

## Setup snaps
install_package snapd
sudo systemctl enable --now snapd
sudo ln -s /var/lib/snapd/snap /snap


## Install snaps
sudo snap install code --classic

## Install RPMs
for p in "${rpm_pkgs[@]}" ; do
    install_package "${p}"
done

## Install flatpak
for p in "${flatpak_pkgs[@]}" ; do
    flatpak install -y "${p}"
done

## Setup syncthing
install_package syncthing
systemctl enable --now --user syncthing
syncthing cli config gui raw-address set '127.0.0.1:8384'

## Install nix
install_nix
