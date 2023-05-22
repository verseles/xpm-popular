#!/usr/bin/env bash
# shellcheck disable=SC2034

readonly xNAME="firefox"
readonly xVERSION="113.0.1"
readonly xTITLE="Mozilla Firefox"
readonly xDESC="A free and open-source web browser developed by the Mozilla Foundation and its subsidiary, the Mozilla Corporation"
readonly xURL="https://www.mozilla.org/firefox"
readonly xARCHS=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="MPL GPL LGPL"
readonly xPROVIDES=("firefox")

readonly xDEFAULT=('apt' 'pacman' 'dnf' 'choco' 'brew')

validate() {
    $1 --version
}

install_any() {
    local file
    file="$($XPM get "http://archive.mozilla.org/pub/firefox/releases/$xVERSION/linux-x86_64/en-US/firefox-$xVERSION.tar.bz2" --no-progress --no-user-agent --name="$xNAME-$xVERSION.tar.bz2")"
    $xSUDO mkdir -p "/opt/$xNAME"
    $xSUDO tar xvf "$file" -C "/opt"
    $xSUDO ln -sf "/opt/$xNAME/$xNAME" "$xBIN/$xNAME"
    $XPM shortcut --name="$xNAME" --path="$xNAME" --icon="/opt/$xNAME/browser/chrome/icons/default/default128.png" --description="$xDESC" --category="Network"
}

remove_any() {
    $xSUDO rm -rf "/opt/$xNAME"
    $xSUDO rm -f "$xBIN/$xNAME"
    $XPM shortcut --remove --name="$xNAME"
}

install_zypper() { # $1 means zypper, so: [sudo] zypper install [package]
    $xSUDO "$1" install mozillaFirefox
}

remove_zypper() { # $1 means zypper -y, so: [sudo] zypper -y remove [package]
    $xSUDO "$1" remove mozillaFirefox
}
