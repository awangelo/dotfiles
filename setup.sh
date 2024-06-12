#!/usr/bin/env bash
set -euo pipefail

NORM="\033[0m"
WARN="\033[38;5;177m"
ERR="\033[31m"
SUC="\033[38;5;123m"

trap 'printf "${ERR}[!] Error in function %s at line %d${NORM}\n" "${FUNCNAME[0]}" "${BASH_LINENO[0]}"; exit 1' ERR EXIT INT TERM HUP

prompt_timer() {
    set +e
    unset promptIn
    local timsec=$1
    local msg=$2
    while [[ ${timsec} -ge 0 ]]; do
        echo -ne "\r :: ${msg} (${timsec}s) : "
        read -t 1 -n 1 promptIn
        [ $? -eq 0 ] && break
        ((timsec--))
    done
    export promptIn
    echo ""
    set -e
}

pre() {
    THREADS=$(nproc)
    # Cores, downloads paralelos e list em tabela
    sudo sed -i "/^#Color/c\Color\nILoveCandy
    /^#VerbosePkgLists/c\VerbosePkgLists
    /^#ParallelDownloads/c\ParallelDownloads = 5" /etc/pacman.conf
    sudo sed -i '/^#\[multilib\]/,+1 s/^#//' /etc/pacman.conf

    echo -e "${SUC}[+] Done with pacman${NORM}"
    # Numero maximo de threads para o makepkg e compressao
    sudo sed -i "/^#MAKEFLAGS=\"-j2\"/c\MAKEFLAGS=\"-j$THREADS\"" /etc/makepkg.conf
    sudo sed -i "s|^COMPRESSXZ=(xz -c -z -)|COMPRESSXZ=(xz -c -z --threads=$THREADS -)|" /etc/makepkg.conf
    sudo sed -i "s|^COMPRESSZST=(zstd -c -z -)|COMPRESSZST=(zstd -c -z --threads=$THREADS -)|" /etc/makepkg.conf
    echo -e "${SUC}[+] Done with makepkg${NORM}"
    # Autologin no tty1 para o usuario atual
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
    echo -e "[Service]\nExecStart=\nExecStart=-/usr/bin/agetty --autologin $(whoami) --noclear %I $TERM" |
        sudo tee /etc/systemd/system/getty@tty1.service.d/override.conf
    echo -e "${SUC}[+] Done with tty autologin${NORM}"
}

aur() {
    git clone https://aur.archlinux.org/yay-bin.git
    (cd yay-bin && makepkg -si)
    echo -e "${SUC}[+] Done with yay${NORM}"
}

install_pkgs() {
    sudo pacman -S --noconfirm --needed base-devel os-prober curl wget
}

grub() {
    # Grub sem timeout para exibir apenas pressionando shift
    sudo sed -i '/GRUB_TIMEOUT=/c\GRUB_TIMEOUT=0' /etc/default/grub
    sudo sed -i '/GRUB_TIMEOUT_STYLE=/c\GRUB_TIMEOUT_STYLE=hidden' /etc/default/grub
    sudo sed -i '/GRUB_DISABLE_OS_PROBER=/c\GRUB_DISABLE_OS_PROBER=false' /etc/default/grub

    # Busca por uma partição EFI do windows em todos os discos
    EFI_PART=$(sudo blkid | grep -i "EFI system" | awk '{print $1}' | cut -d ':' -f 1)

    # Se encontrar, a monta e executa os-prober para adicionar o windows ao grub
    if [ -z "$EFI_PART" ]; then
        prompt_timer 60 "Windows EFI partition not found, continue anyway? [Y/n]"
        OPT=${promptIn,,}
        if [ "$OPT" != "y" ]; then
            exit 1
        fi
    fi

    echo -e "${SUC}[+] Found Windows EFI partition at $EFI_PART${NORM}"
    echo -e "$(lsblk)"
    prompt_timer 60 "Is this the correct EFI partition? [Y/n]"
    OPT=${promptIn,,}
    if [ "$OPT" = "y" ]; then
        sudo mkdir -p /mnt/win
        sudo mount "$EFI_PART" /mnt/win
    else
        exit 1
    fi

    sudo os-prober

    sudo grub-mkconfig -o /boot/grub/grub.cfg
    echo -e "${SUC}[+] Done with grub${NORM}"

    sudo umount /mnt/win
}

nvidia() {
    sudo pacman -S --noconfirm --needed nvidia nvidia-utils nvidia-settings
    echo -e "${WARN}[*] Creating check_drivers.sh script...${NORM}"
    echo "#!/usr/bin/env bash

    echo 'You should NOT see nouveau in the output below:'

    lsmod | grep nouveau
    lsmod | grep nvidia

    nvidia-smi
    " >$HOME/awarch/check_drivers.sh
    chmod +x $HOME/awarch/check_drivers.sh
    echo -e "${SUC}[+] Done with NVIDIA drivers${NORM}"
}

main() {
    sudo pacman -Syyu --noconfirm
    sudo pacman -Fy

    echo -e "${WARN}[*] Starting pacman/makepkg tweaks...${NORM}"
    pre
    echo -e "${WARN}[*] Installing aur...${NORM}"
    aur
    echo -e "${WARN}[*] Installing packages...${NORM}"
    install_pkgs
    echo -e "${WARN}[*] Configuring GRUB...${NORM}"
    grub
    echo -e "${WARN}[*] Installing NVIDIA drivers...${NORM}"
    nvidia

    sudo pacman -Syyu --noconfirm
    sudo pacman -Scc --noconfirm
    yay -Scc --noconfirm

    echo -e "${SUC}[+] Script is done, you should reboot now.${NORM}"
    echo -e "${WARN}[*] Run check_drivers.sh on ~/awarch to check drivers${NORM}"
    echo -e "${WARN}[*] If nvidia is loaded, run rice.sh on ~/awarch${NORM}"
    chmod +x $HOME/awarch/rice.sh

    sudo umount /mnt/win || echo -e "${ERR}[!] Could not unmount Windows EFI partition${NORM}"
}

main
