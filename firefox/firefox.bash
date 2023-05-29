#!/usr/bin/env bash
# shellcheck disable=SC2034 disable=SC2154 disable=SC2164 disable=SC2103

readonly xNAME="firefox"
readonly xVERSION="113.0.1"
readonly xTITLE="Mozilla Firefox"
readonly xDESC="A free and open-source web browser developed by the Mozilla Foundation"
readonly xURL="https://www.mozilla.org/firefox"
readonly xARCHS=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="MPL GPL LGPL"
readonly xPROVIDES=("firefox")

# by using xDEFAULT, it uses $xNAME as the package name and there is no need to use separate functions for each package manager
# So nce you define this, there is no need to create a specfic function for mentioned package manager.
readonly xDEFAULT=('apt' 'pacman' 'dnf' 'choco' 'brew' 'snap')

validate() {
    if [[ $hasFlatpak == true && $(flatpak list | grep $xNAME) ]]; then
        exit 0
    fi
    if [[ -x "$(command -v "$1")" ]]; then
        exit 0
    fi

    exit 1
}

install_any() {
    local binary="http://archive.mozilla.org/pub/firefox/releases/$xVERSION/linux-x86_64/en-US/firefox-$xVERSION.tar.bz2"
    local file
    file="$($XPM get $binary --no-progress --no-user-agent)"
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

install_zypper() { # $1 means zypper with sudo if available, so: [sudo] zypper --non-interactive install [package]
    $1 install mozillaFirefox
}

remove_zypper() { # $1 means zypper with sudo if available, so: [sudo] zypper --non-interactive remove [package]
    $1 remove mozillaFirefox
}

install_flatpak() { # $1 means flatpak with sudo if available
    $1 install flathub org.mozilla.firefox
}

remove_flatpak() {
    $1 remove org.mozilla.firefox
}

install_appimage() {
    # Thanks to https://github.com/srevinsaju/Firefox-Appimage/releases
    # @TODO: add support for channels

    local binary="https://github.com/srevinsaju/Firefox-Appimage/releases/download/firefox/firefox-113.0.r20230522134052-x86_64.AppImage"
    local sha256="79ac00fdc8920ae279d3f00841b4980ef265065aa4373ad098adde26d2fc5775"

    $XPM get $binary --no-progress --no-user-agent --name="$xNAME" --exec --bin --sha256="$sha256"
    $XPM shortcut --sudo --name="$xNAME" --path="$xBIN/$xNAME %u" --description="$xDESC" --category="Network;WebBrowser;" --mime="text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;"
}

remove_appimage() {
    $XPM file unbin $xNAME --sudo --force
    $XPM shortcut --remove --name="$xNAME" --sudo
}
