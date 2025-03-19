#!/bin/bash

install_package() {
    local package=$1
    sudo dnf install -y "${package}"
}

clone_repo() {
    local repo=$1
    local path=$2
    git clone "${repo}" "${path}"
}


disable_selinux() {
    sudo setenforce 0
    sudo sh -c 'echo "SELINUX=disabled" > /etc/selinux/config'
    cat /etc/selinux/config
}

# multi-user
install_nix() {
    sh <(curl -L https://nixos.org/nix/install) --daemon
}
