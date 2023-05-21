#!/usr/bin/env bash
# shellcheck disable=SC2034 disable=SC2154 disable=SC2164 disable=SC2103
# thanks to https://github.com/alexandru-balan/Stremio-Install-Scripts

readonly xNAME="stremio"
readonly xVERSION="4.4.159"
readonly xTITLE="Stremio"
readonly xDESC="A modern media center that's a one-stop solution for your video entertainment"
readonly xURL="https://www.stremio.com/"
readonly xARCHS=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos-x86_64' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="GPL-3.0"

readonly xDEFAULT=()

validate() {
    if [[ $hasFlatpak == true && $(flatpak list | grep $xNAME) ]]; then
        exit 0
    fi
    if [[ ! -x "$(command -v "$1")" ]]; then
        exit 1
    fi
}

install_any() {
    cd "$xTMP"
    # git clone only if directory doesn't exist
    [[ ! -d stremio-shell ]] && git clone --recurse-submodules -j8 https://github.com/Stremio/stremio-shell.git
    cd stremio-shell
    git pull --recurse-submodules -j8
    make -f release.makefile
    $xSUDO make -f release.makefile install
    $xSUDO ./dist-utils/common/postinstall
}

remove_any() {
    $xSUDO rm -rf /usr/local/share/applications/smartcode-stremio.desktop /usr/share/applications/smartcode-stremio.desktop /usr/bin/stremio /opt/stremio
}

install_apt() {
    # @TODO support beta version
    $xSUDO $1 install git cmake librsvg2-bin qtcreator qt5-qmake g++ pkgconf libssl-dev libmpv-dev libqt5webview5-dev libkf5webengineviewer-dev qml-module-qtwebchannel qml-module-qt-labs-platform qml-module-qtwebengine qml-module-qtquick-dialogs qml-module-qtquick-controls qtdeclarative5-dev qml-module-qt-labs-settings qml-module-qt-labs-folderlistmodel

    install_any "$@"
}

remove_apt() {
    remove_any "$@"
}

install_pacman() {
    $1 -S "$xNAME-beta"
}

remove_pacman() {
    $1 -R "$xNAME-beta"
}

install_dnf() {
    $xSUDO $1 install git nodejs wget librsvg2-devel librsvg2-tools mpv-libs-devel qt5-qtbase-devel qt5-qtwebengine-devel qt5-qtquickcontrols qt5-qtquickcontrols2 openssl-devel gcc g++ make glibc-devel kernel-headers binutils

    install_any "$@"
}

remove_dnf() {
    remove_any "$@"
}

install_swupd() {
    $xSUDO $1 bundle-add -y git nodejs-basic wget mpv qt-basic-dev devpkg-qtwebengine lib-qt5webengine c-basic

    install_any "$@"
}

remove_swupd() {
    remove_any "$@"
}

install_zypper() {
    $xSUDO $1 install git nodejs20 mpv-devel rsvg-convert wget libqt5-qtbase-devel libqt5-qtwebengine-devel \
        libqt5-qtquickcontrols libopenssl-devel gcc gcc-c++ make glibc-devel kernel-devel binutils ||
        echo "zypper says some packages are already installed. Proceeding..."

    install_any "$@"
}

remove_zypper() {
    remove_any "$@"
}

install_pack() { # $1 means an executable compatible with snap, flatpack or appimage
    # $hasSnap, $hasFlatpak, $hasAppImage are available as boolean
    if [[ $hasFlatpak == true ]]; then
        $xSUDO $1 install flathub com.stremio.Stremio
    elif [[ $hasAppImage == true ]]; then
        return 1
    else
        return 1
    fi
}

remove_pack() {
    if [[ $hasFlatpak == true ]]; then
        $xSUDO $1 uninstall com.stremio.Stremio
    elif [[ $hasAppImage == true ]]; then
        return 1
    else
        return 1
    fi
}

install_brew() {
    $1 install stremio
}

remove_brew() {
    $1 uninstall stremio
}
