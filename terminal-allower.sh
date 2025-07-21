#!/bin/bash

TERMINAL_FILE_PATH=/usr/bin/bash

disable_term() {
  echo "disable"
  sudo chmod 666 "${TERMINAL_FILE_PATH}"
  stat -c "%a" "${TERMINAL_FILE_PATH}"
}
enable_term() {
  echo "enable"
  sudo chmod 755 "${TERMINAL_FILE_PATH}"
  stat -c "%a" "${TERMINAL_FILE_PATH}"
}

print_help() {
  echo "${0}"
  echo "USAGE:"
  echo "    $0 [COMMAND]"
  echo "COMMANDS:"
  echo "    enable"
  echo "    disable"
}

if [[ $1 == "disable" ]]; then
  disable_term
elif [[ $1 == "enable" ]]; then
  enable_term
else
  print_help
fi
