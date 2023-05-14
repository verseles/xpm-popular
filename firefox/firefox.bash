#!/usr/bin/env bash
# shellcheck disable=SC2034

readonly xNAME="firefox"
readonly xVERSION="112.0.2-2"
readonly xTITLE="Mozilla Firefox"
readonly xDESC="A free and open-source web browser developed by the Mozilla Foundation and its subsidiary, the Mozilla Corporation"
readonly xURL="https://www.mozilla.org/firefox"
readonly xARCH=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="https://www.mozilla.org/en-US/MPL/"
readonly xPROVIDES=("firefox")

readonly xDEFAULT=('apt' 'pacman' 'dnf' 'choco' 'brew' 'termux')

validate() {
    $1 --version
}

install_any() {
    # http://archive.mozilla.org/pub/firefox/releases/113.0.1/linux-x86_64/en-US/firefox-$pkgver.tar.bz2
    echo "$XPM" get "http://archive.mozilla.org/pub/firefox/releases/$xVERSION/$xOS-$xARCH/en-US/$xNAME-$xVERSION.tar.bz2"
}
