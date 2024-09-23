#!/bin/bash

print_help() {
  echo "Usage rednet.sh <adapter-name>"
  exit 0
}


if [[ $# -lt 1 ]]; then
  echo "Network adapter not specified" >&2
  exit 1
fi

if [[ $1 == "help" ]]; then 
  print_help
fi

adapter=$1

echo "Network settings for ${adapter}:"

nmcli connection show "${adapter}" | grep -e connection.id -e IP4

echo "Hostname: $(hostnamectl hostname)"

echo "MAC: $(cat /sys/class/net/"${adapter}"/address)"
