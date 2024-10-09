#!/bin/bash

VIAL_VERSION="v0.7.1"
tmp_dir="/tmp/vial-installer"
VIAL_DOWNLOAD_FILE="${tmp_dir}/vial-${VIAL_VERSION}"
VIAL_DOWNLOAD_ICON="${tmp_dir}/icon.ico"

VIAL_ICON=/usr/local/share/vial/icon.ico
VIAL_EXEC_FILE=/usr/bin/vial
VIAL_DESKTOP_FILE=/usr/share/applications/vial.desktop

download() {
  mkdir -p "${tmp_dir}"
  download_url="https://github.com/vial-kb/vial-gui/releases/download/${VIAL_VERSION}/Vial-${VIAL_VERSION}-x86_64.AppImage"
  wget "${download_url}" -O "${VIAL_DOWNLOAD_FILE}"
  wget https://raw.githubusercontent.com/vial-kb/vial-gui/refs/heads/main/src/main/icons/Icon.ico -O "${VIAL_DOWNLOAD_ICON}"
  chmod +x "${VIAL_DOWNLOAD_FILE}"

  ls "${tmp_dir}"
}

install() {
  cp "${VIAL_DOWNLOAD_FILE}" "${VIAL_EXEC_FILE}"
  cp ./vial.desktop "${VIAL_DESKTOP_FILE}"
  mkdir /usr/local/share/vial/ -p
  cp "${VIAL_DOWNLOAD_ICON}" "${VIAL_ICON}"
}

uninstall() {
  rm "${VIAL_EXEC_FILE}" "${VIAL_DESKTOP_FILE}"
}

help() {
  echo "Vial installer"
  echo ""
  echo "Usage:"
  echo "  $0 <command>"
  echo ""
  echo "Commands:"
  echo "  install     install vial"
  echo "  download    only download package into \$VIAL_DOWNLOAD_FILE"
  echo "  uninstall   uninstalls"
  echo "  help        write this help message"

}

case "$1" in
  download)
    download
    ;;
  install)
    download
    install
    ;;
  uninstall)
    uninstall
    ;;
  -h|--help|help)
    help
    ;;
  *)
    tput setaf 1
    printf "Error command not specified or unknown\n\n" >&2
    tput sgr0
    help >&2
    exit 1
    ;;
esac
