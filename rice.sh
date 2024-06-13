#!/usr/bin/env bash
set -euo pipefail

NORM="\033[0m"
WARN="\033[38;5;177m"
ERR="\033[31m"
SUC="\033[38;5;123m"

trap 'printf "${ERR}[!] Error in function %s at line %d${NORM}\n" "${FUNCNAME[0]}" "${BASH_LINENO[0]}"; exit 1' ERR EXIT INT TERM HUP

archPkg=()
aurPkg=()

installed_pkg() {
    if pacman -Qi "$1" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

pacman_pkg() {
    if pacman -Si "$1" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

aur_pkg() {
    if yay -Si "$1" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

query() {
    while IFS= read -r pkg; do
        if installed_pkg "${pkg}"; then
            echo -e "${WARN}[!] ${pkg} is already installed${NORM}"
        else
            if pacman_pkg "${pkg}"; then
                archPkg+=("${pkg}")
            elif aur_pkg "${pkg}"; then
                aurPkg+=("${pkg}")
            else
                echo -e "${ERR}[!] ${pkg} not found${NORM}"
            fi
        fi
    done < <(cat pkgs.lst)
}

install() {
    if [[ ${#archPkg[@]} -gt 0 ]]; then
        sudo pacman --noconfirm -S "${archPkg[@]}"
    fi

    if [[ ${#aurPkg[@]} -gt 0 ]]; then
        yay --noconfirm -S "${aurPkg[@]}"
    fi
}

config() {
    
}

main() {
    check_setup
    query
    install
}

main
