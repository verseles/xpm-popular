#!/usr/bin/env bash
# shellcheck disable=SC2034 disable=SC2154 disable=SC2164 disable=SC2103

readonly xNAME="ChatALL"
readonly xVERSION="1.28.32"
readonly xTITLE="ChatALL"
readonly xDESC="Chat with ALL AI Bots Concurrently, Discover the Best"
readonly xURL="https://chatall.ai"
readonly xARCHS=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64')
readonly xLICENSE="GPL-2.0-only"

readonly xDEFAULT=('pacman')

validate() {
    if [[ $hasFlatpak == true && $(flatpak list | grep $xNAME) ]]; then
        exit 0
    fi
    if [[ -x "$(command -v "$1")" ]]; then
        exit 0
    fi

    exit 1
}

install_appimage() {
    local binary="https://github.com/sunner/ChatALL/releases/download/v$xVERSION/ChatALL-$xVERSION-$xOS-$xARCH.AppImage"
    $xSUDO $XPM get "$binary" --no-progress --no-user-agent --name="$xNAME" --exec --bin
    $xSUDO $XPM shortcut --name="$xNAME" --path="$xBIN/$xNAME" --description="$xDESC" --category="Network"
}

remove_appimage() {
    $XPM file unbin $xNAME --sudo --force
    $XPM shortcut --remove --name="$xNAME" --sudo
}
