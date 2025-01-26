#!/bin/bash

export GUM_SPIN_SHOW_ERROR=true
export GUM_SPIN_ALIGN="right"
export GUM_LOG_LEVEL_FOREGROUND="#b8bb26"
export GUM_LOG_KEY_FOREGROUND="#928374"
export GUM_LOG_VALUE_FOREGROUND="#fbf1c7"

TRUE=0
FALSE=1

program_exist() {
  local program=$1
  if [ $(command -v "${program}") ]; then
    gum log \
      --level.foreground "#83a598" \
      --structured \
      --level debug \
      "${program} found" exec "'$(which ${program})'"
    return $TRUE
  fi
  return $FALSE
}

print_sudo_warn() {
  gum log \
    --level warn \
    --level.foreground "#fabd2f" \
    "Sudo will be used"
}

execute() {

  gum log --level info "Starting packages clearing"

  if $(program_exist nix-env); then
    gum spin --title "Clearing home-manager generations older than 0 min" -- \
      home-manager expire-generations -0min
    gum spin --title "Clearing nix generations" -- \
      nix-env --delete-generations +1
    gum spin --title "Collecting garbage in nix" -- \
      nix-store --gc
    gum log --level info "Nix packages cleared"
  fi

  if $(program_exist pacman); then

    local pacman_exec
    pacman_exec='pacman'

    if $(program_exist yay); then
      pacman_exec='yay'
    fi
    if $(program_exist paru); then
      pacman_exec='paru'
    fi

    gum log --level info "Executable for pacman: '$(which ${pacman_exec})'"

    print_sudo_warn

    gum spin \
      --title "Clearing pacman orphanes" \
      --show-output \
      -- "${pacman_exec} -Qqttd | sudo ${pacman_exec} -Rsu --noconfirm -"
    gum log --level info "Pacman orphanes cleared"
  fi

  if $(program_exist flatpak); then
    gum spin --title "Clearing unused flatpaks" -- \
      flatpak uninstall --unused -y
    gum log --level info "Flatpak packages cleared"
  fi

  if $(program_exist dnf); then
    gum spin --title "Clearing dnf packages" -- \
      pkexec dnf autoremove -y
    gum spin --title "Clearing dnf cache" -- \
      pkexec dnf --verbose clean dbcache all
    gum log --level info "Dnf unused packages and cache cleared"
  fi

  if $(program_exist docker); then
    # gum log --level warn "Sudo will be used"
    gum spin --title "Clearing docker containers, images, volumes" -- \
      "
      pkexec docker container prune --force
      pkexec docker image prune --force
      pkexec docker volume prune --force
      "
    gum log --level info "Docker images, containers, volumes cleared"
  fi

  gum log --level info "Packages clearing done"
}

# if [[ $USER != "root" ]]; then
#   gum format "This script should be run only as root, so you should use \`sudo $0\` or \`pkexec $0\`
#   > Sit down punk..."
#   exit 1
# fi

execute
