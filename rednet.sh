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

# Prints MAC address into sdtout
# $1 - connection 
get_mac() {
  local connection=$1
  cat /sys/class/net/"${connection}"/address
}

# $1 - MAC address
print_manufacturer() {
  local mac=$1
  local mac_info
  local company
  mac_info=$(curl https://api.maclookup.app/v2/macs/${mac} -s)
  company=$(echo "${mac_info}" | jq -r ".company")

  echo "Manufacturer: ${company}"
}

if [[ $# -lt 1 ]]; then
  echo "Network adapter not specified" >&2
  echo "You can use following adapters:" >&2
  print_adapters >&2
  exit 1
fi

if [[ $1 == "help" || $1 == "--help" ]]; then 
  print_help
fi

if [[ $1 == "adapters" ]]; then 
  print_adapters
  exit 0
fi

CONNECTION=$1

echo "Network settings for ${CONNECTION}:"

nmcli connection show "${CONNECTION}" | grep -e connection.id -e IP4

echo "Hostname: $(hostnamectl hostname)"

MAC=$(get_mac "${CONNECTION}")

echo "MAC: ${MAC}"
print_manufacturer "${MAC}"
