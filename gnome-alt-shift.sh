#!/bin/bash

gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Super>Space', '<Shift>Alt_L', '<Shift>Alt_R']"
gsettings get org.gnome.desktop.wm.keybindings switch-input-source

gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Alt>Shift_L', '<Alt>Shift_R']"
gsettings get org.gnome.desktop.wm.keybindings switch-input-source-backward
