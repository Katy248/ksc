
echo "Remove \`kms\` from HOOKS in file /etc/mkinitcpio.conf and then rerun script"
echo "Othervise press Enter"
read

sudo pacman -Syu --no-confirm\
  nvidia-dkms nvidia-utils nvidia-settings lib32-nvidia-utils opencl-nvidia vulkan-icd-loader lib32-vulkan-icd-loader

sudo mkinitcpio -P


echo "Don't forget to reboot after running this script"
