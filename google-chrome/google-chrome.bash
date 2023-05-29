#!/usr/bin/env bash
# shellcheck disable=SC2034 disable=SC2154 disable=SC2164 disable=SC2103

readonly xNAME="google-chrome"
readonly xVERSION="113.0.5672.126"
readonly xTITLE="Google Chrome"
readonly xDESC="Fast, secure, and free web browser built for the modern web"
readonly xURL="https://www.google.com/chrome/"
readonly xARCHS=('linux64' 'linux32' 'macos' 'win32' 'win64')
readonly xLICENSE="proprietary"

readonly xDEFAULT=('pacman' 'brew')

validate() {
    if [[ $hasFlatpak == true && $(flatpak list | grep $xNAME) ]]; then
        exit 0
    fi
    if [[ -x "$(command -v "$1")" ]]; then
        exit 0
    fi

    exit 1
}

install_apt() {
    $1 install -y gpg wget
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | $xSUDO apt-key add -
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | $xSUDO tee /etc/apt/sources.list.d/google-chrome.list
    $1 update
    $1 install -y google-chrome-stable
}

remove_apt() {
    $1 remove -y google-chrome-stable
    $1 autoremove -y
    $xSUDO rm -f /etc/apt/sources.list.d/google-chrome.list
}

install_dnf() {
    $1 install -y fedora-workstation-repositories
    $1 config-manager --set-enabled google-chrome
    $1 install -y google-chrome-stable
}

remove_dnf() {
    $1 remove -y google-chrome-stable
    $1 config-manager --disable google-chrome
}

install_zypper() {
    $1 ar -f http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
    $1 refresh
    $1 install -y google-chrome-stable
}

remove_zypper() {
    $1 remove -y google-chrome-stable
    $1 clean -y
    $1 rr Google-Chrome
}

install_flatpak() {
    $1 install -y flathub com.google.Chrome
}

remove_flatpak() {
    $1 uninstall -y com.google.Chrome
}

install_swupd() {
    $1 bundle-add desktop -W4
    flatpak -y --noninteractive install flathub com.google.Chrome
}

remove_swupd() {
    flatpak -y --noninteractive uninstall flathub com.google.Chrome
}
