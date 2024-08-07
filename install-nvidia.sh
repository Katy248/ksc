
bold=$(tput bold)
normal=$(tput sgr0)

echo "Remove \`kms\` from HOOKS in file /etc/mkinitcpio.conf and then rerun script"
echo "Othervise press Enter"
read

echo "There is several drivers for nvidia:"
echo " - ${bold}nvidia${normal} - for ${bold}linux${normal} kernel"
echo " - ${bold}nvidia-lts${normal} - for ${boldl}inux-lts${normal} kernel"
echo " - ${bold}nvidia-dkms${normal} - for other kernels"
echo ""

echo "Input your driver:"
printf "Driver: "
read -r driver

printf "This script will use sudo, continue? [Enter/Ctrl+C] "
read

sudo pacman -Syu "${driver}" nvidia-utils nvidia-settings lib32-nvidia-utils opencl-nvidia vulkan-icd-loader lib32-vulkan-icd-loader --noconfirm
sudo mkinitcpio -P

echo -e "\n\n"
echo "Don't forget to reboot after running this script"
