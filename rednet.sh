#!/bin/bash

adapter=$1

echo "Network settings for ${adapter}:"

nmcli connection show "${adapter}" | grep -e connection.id -e IP4

echo "Hostname: $(hostnamectl hostname)"

echo "MAC: $(cat /sys/class/net/"${adapter}"/address)"
