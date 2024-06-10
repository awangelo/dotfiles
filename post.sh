#!/bin/bash
set -e

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
#makepkg
    sudo sed -i '/^#MAKEFLAGS="-j2"/c\MAKEFLAGS="-j$THREADS"' /etc/makepkg.conf
    sudo sed -i '/^COMPRESSXZ=(xz -c -z -)/c\COMPRESSXZ=(xz -c -z --threads=$THREADS -)' /etc/makepkg.conf
    sudo sed -i '/^COMPRESSZST=(zstd -c -z -)/c\COMPRESSZST=(zstd -c -z --threads=$THREADS -)' /etc/makepkg.conf
#autologin
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
    echo -e "[Service]\nExecStart=\nExecStart=-/usr/bin/agetty --autologin $(whoami) --noclear %I $TERM" \
    | sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf
}

aur() {
    TEMPDIR="$HOME/awarch" && mkdir -p $TEMPDIR && cd $TEMPDIR
    git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin
    makepkg -si
    cd $TEMPDIR && rm -rf $TEMPDIR
}

installpkg() {
    sudo pacman -S --noconfirm --needed \
        base-devel os-prober neovim \
        curl wget  
}

nvidia() {
    cat /usr/lib/modules/*/pkgbase | while read krnl; do
        echo "${krnl}-headers" >> 
    done
}

echo -e "${WARNING}[*]: Starting pacman/makepkg tweaks...${NORMAL}"
pre
echo -e "${WARNING}[*]: Installing aur...${NORMAL}"
aur
echo -e "${WARNING}[*]: Installing packages...${NORMAL}"
installpkg
echo -e "${WARNING}[*]: Installing NVIDIA drivers...${NORMAL}"
nvidia
echo -e "${SUCCESS}[*]: Script is done, you should reboot now.${NORMAL}"
