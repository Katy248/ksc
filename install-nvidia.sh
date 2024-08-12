#!/bin/bash

export GUM_THEME="gruvbox"
gum format \
  "Remove \`kms\` from HOOKS in file \`/etc/mkinitcpio.conf\` and then rerun script" \
  "Othervise press \`Enter\`"

if gum confirm "Continue?" ; then
  gum format "_Cool!_"
else 
  gum format "_See you!_"
  exit 1
fi


gum format \
  "There is a several drivers for **nvidia**:" \
  " - **nvidia** - for **linux** kernel" \
  " - **nvidia-lts** - for **linux-lts** kernel" \
  " - **nvidia-dkms** - for other kernels" \
  "Your current kernel release is \`$(uname -r)\`"

echo ""

driver=$(gum choose \
  --limit 1 \
  --select-if-one \
  --header "Choose your driver:" \
  "nvidia" \
  "nvidia-lts" \
  "nvidia-dkms")


if ! gum confirm "This script will use sudo, continue?" ; then
  gum format "_So goodbye now!_"
  exit 1
fi

sudo pacman -Syu "${driver}" nvidia-utils nvidia-settings lib32-nvidia-utils opencl-nvidia vulkan-icd-loader lib32-vulkan-icd-loader --noconfirm
sudo mkinitcpio -P

echo ""

gum format "Don't forget to reboot after running this script"
