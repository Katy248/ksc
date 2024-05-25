
echo "Remove \`kms\` from HOOKS in file /etc/mkinitcpio.conf and then rerun script"
echo "Othervise press Enter"
read

sudo pacman -Syu nvidia-dkms nvidia-utils nvidia-settings lib32-nvidia-utils opencl-nvidia --no-confirm
sudo mkinitcpio -P


echo "Don't forget to reboot after running this script"
