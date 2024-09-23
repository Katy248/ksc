#!/bin/bash

print_help() {
  echo "Usage:"
  echo "    rednet.sh <adapter-name>"
  echo "    rednet.sh adapters"
  echo "    rednet.sh help" 
  exit 0
}

print_adapters() {
  nmcli --fields DEVICE --terse connection show --active
}




if [[ $# -lt 1 ]]; then
  echo "Network adapter not specified" >&2
  echo "You can use following adapters:"
  print_adapters
  exit 1
fi

if [[ $1 == "help" ]]; then 
  print_help
fi

if [[ $1 == "adapters" ]]; then 
  print_adapters
  exit 0
fi

adapter=$1

echo "Network settings for ${adapter}:"

nmcli connection show "${adapter}" | grep -e connection.id -e IP4

echo "Hostname: $(hostnamectl hostname)"

echo "MAC: $(cat /sys/class/net/"${adapter}"/address)"
