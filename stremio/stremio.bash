#!/usr/bin/env bash
# shellcheck disable=SC2034 disable=SC2154 disable=SC2164 disable=SC2103
# thanks to https://github.com/alexandru-balan/Stremio-Install-Scripts

readonly xNAME="stremio"
readonly xVERSION="4.4.159"
readonly xTITLE="Stremio"
readonly xDESC="A modern media center that's a one-stop solution for your video entertainment"
readonly xURL="https://www.stremio.com/"
readonly xARCHS=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
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

install_apt() {
    # @TODO support beta version
    $xSUDO $1 install nodejs libmpv1 qml-module-qt-labs-platform qml-module-qtquick-controls qml-module-qtquick-dialogs qml-module-qtwebchannel qml-module-qtwebengine qml-module-qt-labs-folderlistmodel qml-module-qt-labs-settings librubberband2 libuchardet0

    local fdk_aac_url="http://archive.ubuntu.com/ubuntu/pool/multiverse/f/fdk-aac/libfdk-aac1_0.1.6-1_amd64.deb"
    $xSUDO dpkg -i "$($XPM get $fdk_aac_url --no-progress)"

    local libssl_url="http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1-1ubuntu2.1~18.04.22_amd64.deb"
    $xSUDO dpkg -i "$($XPM get $libssl_url --no-progress)"

    local file_url="https://dl.strem.io/shell-linux/v$xVERSION/${xNAME}_${xVERSION}-1_amd64.deb"
    $xSUDO dpkg -i "$($XPM get $file_url --no-progress)"

    $1 install -f # stands for apt/apt-get --fix-broken install
}

remove_apt() {
    $xSUDO dpkg -r "$xNAME"
}

install_pacman() {
    if [[ -n $xCHANNEL ]]; then
        $1 -S --needed "$xNAME-$xCHANNEL"
    else
        $1 -S --needed $xNAME
    fi
}

remove_pacman() {
    if [[ -n $xCHANNEL ]]; then
        $1 -R "$xNAME-$xCHANNEL"
    else
        $1 -R $xNAME
    fi
}

install_dnf() {
    $xSUDO $1 install git nodejs wget librsvg2-devel librsvg2-tools mpv-libs-devel qt5-qtbase-devel qt5-qtwebengine-devel qt5-qtquickcontrols qt5-qtquickcontrols2 openssl-devel gcc g++ make glibc-devel kernel-headers binutils

    cd "$xTMP"
    # git clone only if directory doesn't exist
    [[ ! -d stremio-shell ]] && git clone --recurse-submodules -j8 https://github.com/Stremio/stremio-shell.git
    cd stremio-shell
    sed -i 's/qmake/qmake-qt5/g' release.makefile
    qmake-qt5
    make -f release.makefile
    $xSUDO make -f release.makefile install
    $xSUDO ./dist-utils/common/postinstall
}

remove_dnf() {
    $xSUDO rm -rf /usr/local/share/applications/smartcode-stremio.desktop /usr/share/applications/smartcode-stremio.desktop /usr/bin/stremio /opt/stremio
}

install_swupd() {
    $xSUDO $1 bundle-add -y git nodejs-basic wget mpv qt-basic-dev devpkg-qtwebengine lib-qt5webengine c-basic

    cd "$xTMP"
    # git clone only if directory doesn't exist
    [[ ! -d stremio-shell ]] && git clone --recurse-submodules -j8 https://github.com/Stremio/stremio-shell.git
    cd stremio-shell
    qmake
    make -f release.makefile
    $xSUDO make -f release.makefile install
    $xSUDO ./dist-utils/common/postinstall
}

remove_swupd() {
    $xSUDO rm -rf /usr/local/share/applications/smartcode-stremio.desktop /usr/share/applications/smartcode-stremio.desktop /usr/bin/stremio /opt/stremio
}

install_zypper() {
    $xSUDO $1 install git nodejs20 mpv-devel rsvg-convert wget libqt5-qtbase-devel libqt5-qtwebengine-devel \
        libqt5-qtquickcontrols libopenssl-devel gcc gcc-c++ make glibc-devel kernel-devel binutils ||
        echo "zypper says some packages are already installed. Proceeding..."

    cd "$xTMP"
    # git clone only if directory doesn't exist
    [[ ! -d stremio-shell ]] && git clone --recurse-submodules -j8 https://github.com/Stremio/stremio-shell.git
    cd stremio-shell
    make -f release.makefile
    $xSUDO make -f release.makefile install
    $xSUDO ./dist-utils/common/postinstall
}

remove_zypper() {
    $xSUDO rm -rf /usr/local/share/applications/smartcode-stremio.desktop /usr/share/applications/smartcode-stremio.desktop /usr/bin/stremio /opt/stremio
}

install_pack() { # $1 means an executable compatible with snap, flatpack or appimage
    # $hasSnap, $hasFlatpak, $hasAppImage are available as boolean
    if [[ $hasFlatpak == true ]]; then
        $xSUDO $1 install flathub com.stremio.Stremio
    elif [[ $hasAppImage == true ]]; then
        # $1 install $xNAME
        return 1
    else
        $1 install $xNAME
    fi
}

remove_pack() {
    if [[ $hasFlatpak == true ]]; then
        $xSUDO $1 uninstall com.stremio.Stremio
    elif [[ $hasAppImage == true ]]; then
        # $1 remove $xNAME
        return 1
    else
        $1 remove $xNAME
    fi
}
