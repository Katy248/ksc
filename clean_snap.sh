#!/bin/bash

set -eu

export LANG=C.UTF-8

snap list --all | awk '/disabled/{print $1, $3}' |
     while read -r snapname revision; do
         snap remove "$snapname" --revision="$revision"
     done
