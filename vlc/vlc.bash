#!/usr/bin/env bash
# shellcheck disable=SC2034 disable=SC2154 disable=SC2164 disable=SC2103

readonly xNAME="vlc"
readonly xVERSION="3.0.18"
readonly xTITLE="VLC media player"
readonly xDESC="A free and open-source, portable, cross-platform media player software and streaming media server"
readonly xURL="https://www.videolan.org/vlc"
readonly xARCHS=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="GPL-2.0-only"

readonly xDEFAULT=('apt' 'pacman' 'dnf' 'choco' 'brew' 'zypper' 'snap')

validate() {
    if [[ $hasFlatpak == true && $(flatpak list | grep $xNAME) ]]; then
        exit 0
    fi
    if [[ -x "$(command -v "$1")" ]]; then
        exit 0
    fi

    exit 1
}

install_flatpak() {
    # $1 is flatpak with sudo if available
    $1 install flathub org.videolan.VLC
}

remove_flatpak() {
    # $1 is flatpak with sudo if available
    $1 remove org.videolan.VLC
}

install_appimage() {
    local binary="https://github.com/ivan-hc/VLC-appimage/releases/download/continuous/VLC_media_player-3.0.19-20230521-with-plugins-x86_64.AppImage"
    local sha256="b892ddab8120ad117073ca4c89b5b079abd09f6d8eabdcf49578df25d4e2b762"
    $XPM get --no-progress --no-user-agent --name="$xNAME" --exec --bin --sha256="$sha256"
    $XPM shortcut --name="$xNAME" --path="$xBIN/$xNAME" --description="$xDESC" --category="Multimedia"
}

remove_appimage() {
    $XPM file unbin $xNAME --sudo --force
    $XPM shortcut --remove --name="$xNAME" --sudo
}
