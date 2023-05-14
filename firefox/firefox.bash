#!/usr/bin/env bash
# shellcheck disable=SC2034

readonly xNAME="firefox"
readonly xVERSION="113.0.1"
readonly xTITLE="Mozilla Firefox"
readonly xDESC="A free and open-source web browser developed by the Mozilla Foundation and its subsidiary, the Mozilla Corporation"
readonly xURL="https://www.mozilla.org/firefox"
readonly xARCH=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="MPL GPL LGPL"
readonly xPROVIDES=("firefox")

readonly xDEFAULT=('apt' 'pacman' 'dnf' 'choco' 'brew' 'termux')

validate() {
    $1 --version
}

install_any() {
    local file
    file="$($XPM get "http://archive.mozilla.org/pub/firefox/releases/$xVERSION/linux-x86_64/en-US/firefox-$xVERSION.tar.bz2" --no-progress --no-user-agent --name="$xNAME-$xVERSION.tar.bz2")"
    $ySUDO mkdir -p "/opt/$xNAME"
    $ySUDO tar xvf "$file" -C "/opt"
    $ySUDO ln -sf "/opt/$xNAME/$xNAME" "$yBIN/$xNAME"
    $XPM shortcut --name="$xNAME" --path="$xNAME" --icon="/opt/$xNAME/browser/chrome/icons/default/default128.png" --description="$xDESC" --category="Network"
}

remove_any() {
    $ySUDO rm -rf "/opt/$xNAME"
    $ySUDO rm -f "$yBIN/$xNAME"
    #$XPM shortcut --remove="$xNAME"
}

install_zypper() { # $1 means [sudo] zypper -y install [package]
    $1 install mozillaFirefox
}

remove_zypper() { # $1 means [sudo] zypper -y remove [package]
    $1 remove mozillaFirefox
}
