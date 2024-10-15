#!/bin/bash

print_help() {
  echo "Usage:"
  echo "  rednet.sh {<adapter-name>|command} [options]"
  echo "  rednet.sh <adapter-name>"
  echo "  rednet.sh adapters"
  echo "Commands:"
  echo "  adapters  Print all available adapters"
  echo "Options:"
  echo "  --help    Shows help message"
  exit 0
}

print_adapters() {
  nmcli --fields NAME --terse connection show
}

if [[ $# -lt 1 ]]; then
  echo "Network adapter not specified" >&2
  echo "You can use following adapters:"
  print_adapters
  exit 1
fi

if [[ $1 == "help" || $1 == "--help" ]]; then 
  print_help
fi

if [[ $1 == "adapters" ]]; then 
  print_adapters
  exit 0
fi

connection=$1

echo "Network settings for ${connection}:"

nmcli connection show "${connection}" | grep -e connection.id -e IP4

echo "Hostname: $(hostnamectl hostname)"

echo "MAC: $(cat /sys/class/net/"${connection}"/address)"
