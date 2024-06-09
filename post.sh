#!/bin/bash

THREADS=$(nproc)
USER=$(whoami)
TEMPDIR=$(/tmp/awarch)
mkdir -p $TEMPDIR

NORMAL="\033[0m"
WARNING="\033[35;5;11m"
ERROR="\033[31;5;11m"

pre() {
    echo -e "${WARNING}[*]: Starting pacman/makepkg tweaks...${NORMAL}"
#pacman
    sudo sed -i "/^#Color/c\Color\nILoveCandy
    /^#VerbosePkgLists/c\VerbosePkgLists
    /^#ParallelDownloads/c\ParallelDownloads = 5" /etc/pacman.conf
    sudo sed -i '/^#\[multilib\]/,+1 s/^#//' /etc/pacman.conf

    sudo pacman -Syyu
    sudo pacman -Fy
#makepkg
    sudo sed -i "/^#MAKEFLAGS="-j2"/c\MAKEFLAGS="-j$THREADS"" /etc/makepkg.conf
    sudo sed -i "/^COMPRESSXZ=(xz -c -z -)/c\COMPRESSXZ=(xz -c -z --threads=$THREADS -)" /etc/makepkg.conf
    sudo sed -i "/^COMPRESSZST=(zstd -c -z -)/c\COMPRESSZST=(zstd -c -z --threads=$THREADS -)" /etc/makepkg.conf
#autologin
    echo -e "[Service]\nExecStart=\nExecStart=-/sbin/agetty --autologin $username --ar %I $TERM" | sudo tee /etc/systemd/system/agetty@tty1.service.d/override.conf
}

aur() {
    echo -e "${WARNING}[*]: Installing yay...${NORMAL}"
    cd $TEMPDIR
    git clone https://aur.archlinux.org/yay-bin.git
    cd $TEMPDIR/yay-bin
    makepkg -si
}

intallpkg() {
    echo -e "${WARNING}[*]: Installing packages...${NORMAL}"
    sudo pacman -S --noconfirm --needed \
        base-devel \
        git \
        os-prober \
}

nvidia() {
    echo -e "${WARNING}[*]: Installing NVIDIA drivers...${NORMAL}"
    cat /usr/lib/modules/*/pkgbase | while read krnl; do
        echo "${krnl}-headers" >> 
    done
}

#grub
sudo mkdir /mnt/windows && sudo mount /dev/sdb1 /mnt/windows
cat "\e[33m[*] os-prober: Detecting other OSes\e[0m"
sudo os-prober
echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

#post
echo "You should now reboot the system."