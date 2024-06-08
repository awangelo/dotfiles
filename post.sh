#!/bin/bash

#pre
tempdir=$($HOME/awarch)
cd $tempdir
sudo pacman -Syyuu
sudo pacman -S git base-devel reflector os-prober

#tty
echo -e "\e[31mWARNING: Enter username for autologin:\e[0m"
read username
echo -e "[Service]\nExecStart=\nExecStart=-/sbin/agetty --autologin $username --noclear %I $TERM" | sudo tee /etc/systemd/system/agetty@tty1.service.d/override.conf

#pacman
sudo reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
echo $'[options]\nParralelDownloads = 5' | sudo tee -a $HOME/sctest/pacman.conf
echo $'MAKEFLAGS="-j$(nproc)"' | sudo tee -a $HOME/sctest/makepkg.conf

#make
echo "COMPRESSXZ=(xz -c -z --threads=$(nproc) -)" | sudo tee -a $HOME/sctest/makepkg.conf
echo "COMPRESSZST=(zstd -c -z --threads=$(nproc) -)" | sudo tee -a $HOME/sctest/makepkg.conf

#aur
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
yay -Syu --devel
sudo pacman -Syyuu
yay -Syyuu

#grub
sudo mkdir /mnt/windows && sudo mount /dev/sdb1 /mnt/windows
cat "[*] os-prober: Detecting other OSes"
sudo os-prober
echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

#post
echo "You should now reboot the system."