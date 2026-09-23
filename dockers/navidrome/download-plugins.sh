#!/bin/bash

source .env

mkdir -p "${PLUGINS_DIR}"

plugins_list=(
  'https://github.com/kgarner7/navidrome-listenbrainz-daily-playlist/releases/download/v6.0.0/listenbrainz-daily-playlist.ndp'
)

for p in "${plugins_list[@]}"; do
  wget -P "${PLUGINS_DIR}" "${p}"
done
