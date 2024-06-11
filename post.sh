#!/usr/bin/env bash
set -euo pipefail

NORMAL="\033[0m"
WARNING="\033[35;5;11m"
ERROR="\033[31;5;11m"
SUCCESS="\033[32;5;11m"

trap 'echo -e "${ERROR}Error in function $FUNCNAME at line $LINENO${NORMAL}"; exit 1' ERR

pre() {
    THREADS=$(nproc)
#pacman
    sudo sed -i "/^#Color/c\Color\nILoveCandy
    /^#VerbosePkgLists/c\VerbosePkgLists
    /^#ParallelDownloads/c\ParallelDownloads = 5" /etc/pacman.conf
    sudo sed -i '/^#\[multilib\]/,+1 s/^#//' /etc/pacman.conf

    sudo pacman -Syyu
    sudo pacman -Fy
    echo -e "${NORMAL}[+] Done with pacman${NORMAL}"
#makepkg
    sudo sed -i "/^#MAKEFLAGS=\"-j2\"/c\MAKEFLAGS=\"-j$THREADS\"" /etc/makepkg.conf
    sudo sed -i '/^COMPRESSXZ=(xz -c -z -)/c\COMPRESSXZ=(xz -c -z --threads=$THREADS -)' /etc/makepkg.conf
    sudo sed -i '/^COMPRESSZST=(zstd -c -z -)/c\COMPRESSZST=(zstd -c -z --threads=$THREADS -)' /etc/makepkg.conf
    echo -e "${NORMAL}[+] Done with makepkg${NORMAL}"
#autologin
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
    echo -e "[Service]\nExecStart=\nExecStart=-/usr/bin/agetty --autologin $(whoami) --noclear %I $TERM" \
    | sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf
    echo -e "${NORMAL}[+] Done with tty autologin${NORMAL}"
}

aur() {
    TEMPDIR="$HOME/awarch"
    mkdir -p $TEMPDIR
    (cd $TEMPDIR && git clone https://aur.archlinux.org/yay-bin.git && \
    cd yay-bin && makepkg -si)
    rm -rf $TEMPDIR
    echo -e "${NORMAL}[+] Done with yay${NORMAL}"
}

installpkg() {
    sudo pacman -S --noconfirm --needed \
        base-devel os-prober neovim \
        curl wget 
}

grub() {
    sudo sed -i '/GRUB_TIMEOUT=/c\GRUB_TIMEOUT=0' /etc/default/grub
    sudo sed -i '/GRUB_TIMEOUT_STYLE=/c\GRUB_TIMEOUT_STYLE=hidden' /etc/default/grub
    sudo sed -i '/GRUB_DISABLE_OS_PROBER=/c\GRUB_DISABLE_OS_PROBER=false' /etc/default/grub

    PARTITION=$(lsblk -f | grep 'ntfs' | awk '{print "/dev/" $1}')
    echo -e "${WARNING}[*]: Found Windows partition at $PARTITION${NORMAL}"
    sudo os-prober
    sudo mkdir -p /mnt/windows
    sudo mount $PARTITION /mnt/windows

    sudo grub-mkconfig -o /boot/grub/grub.cfg

    echo -e "${NORMAL}[+] Done with grub${NORMAL}"
}

nvidia() {
    sudo pacman -S --noconfirm --needed nvidia nvidia-utils nvidia-settings
    echo -e "${WARNING}[*]: Creating check_drivers.sh script...${NORMAL}"
    echo "#!/bin/bash

    echo 'Checking if Nouveau is unloaded...'
    if lsmod | grep -q nouveau; then
        echo 'Nouveau is loaded!'
    else
        echo 'Nouveau is not loaded.'
    fi
    echo 'Checking if Nvidia is loaded...'
    if lsmod | grep -q nvidia; then
        echo 'Nvidia is loaded!'
    else
        echo 'Nvidia is not loaded.'
    fi

    echo 'Checking Nvidia driver version...'
    nvidia-smi
    " > ~/check_drivers.sh
    chmod +x ~/check_drivers.sh
    echo -e "${NORMAL}[+] Done with NVIDIA drivers${NORMAL}"
}

echo -e "${WARNING}[*]: Starting pacman/makepkg tweaks...${NORMAL}"
pre
echo -e "${WARNING}[*]: Installing aur...${NORMAL}"
aur
echo -e "${WARNING}[*]: Installing packages...${NORMAL}"
installpkg
echo -e "${WARNING}[*]: Configuring GRUB...${NORMAL}"
grub
echo -e "${WARNING}[*]: Installing NVIDIA drivers...${NORMAL}"
nvidia
echo -e "${WARNING}[*]: Execute check_drivers.sh after reboot to check the drivers.${NORMAL}"
echo -e "${SUCCESS}[*]: Script is done, you should reboot now.${NORMAL}"