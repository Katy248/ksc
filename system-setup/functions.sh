#!/bin/bash

apt_install() {
    local bin=$1
    local package=$2
    sudo ${bin} install -y "${package}"
}

install_package() {
    local package=$1
    if command -v dnf; then
        sudo dnf install -y "${package}"
        return
    fi
    
    if command -v nala; then
        apt_install nala $package
        elif command -v apt; then
        apt_install apt $package
    fi
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
    figlet 'Installing nix'
    if command -v setenforce ; then
        figlet 'single-user (SELinux exists)'
        sudo chown -R katy /nix
        sh <(curl -L https://nixos.org/nix/install) --no-daemon
    else
        figlet 'multi-user'
        sh <(curl -L https://nixos.org/nix/install) --daemon
    fi
}
