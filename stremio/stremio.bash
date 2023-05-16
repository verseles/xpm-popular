#!/usr/bin/env bash
# shellcheck disable=SC2034

readonly xNAME="stremio"
readonly xVERSION="4.4.159"
readonly xTITLE="Stremio"
readonly xDESC="A modern media center that's a one-stop solution for your video entertainment"
readonly xURL="https://www.stremio.com/"
readonly xARCH=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="GPL-3.0"
readonly xPROVIDES=("stremio")

readonly xDEFAULT=()

validate() {
    $1 --version
}

install_apt() {
    $1 install --only-upgrade nodejs libmpv1 qml-module-qt-labs-platform qml-module-qtquick-controls qml-module-qtquick-dialogs qml-module-qtwebchannel qml-module-qtwebengine qml-module-qt-labs-folderlistmodel qml-module-qt-labs-settings librubberband2 libuchardet0

    local fdk_aac_url="http://archive.ubuntu.com/ubuntu/pool/multiverse/f/fdk-aac/libfdk-aac1_0.1.6-1_amd64.deb"
    $ySUDO dpkg -i "$($XPM get $fdk_aac_url --no-progress)"

    local file_url="https://dl.strem.io/shell-linux/v$xVERSION/${xNAME}_${xVERSION}-1_amd64.deb"
    $ySUDO dpkg -i "$($XPM get $file_url --no-progress)"

    $1 install -f # stands for apt/apt-get --fix-broken install
}

remove_apt() {
    $ySUDO dpkg -r "$xNAME"
}

install_pacman() {
    if [[ -n $yCHANNEL ]]; then
        $1 -S --needed "$xNAME-$yCHANNEL"
    else
        $1 -S --needed $xNAME
    fi
}

remove_pacman() {
    if [[ -n $yCHANNEL ]]; then
        $1 -R "$xNAME-$yCHANNEL"
    else
        $1 -R $xNAME
    fi
}

install_dnf() {
    $1 install -y $xNAME
}

# update commands will be called before install_pack and remove_pack
install_pack() { # $1 means an executable compatible with snap, flatpack or appimage
    # $isSnap, $isFlatpack, $isAppimage are available as boolean
    # shellcheck disable=SC2154
    if [[ $isFlatpack == true ]]; then # actually micro is not available on flatpack
        # $1 install $xNAME                   # with --assumeyes
        return 1
    elif [[ $isAppimage == true ]]; then
        # $1 install $xNAME
        return 1
    else
        $1 install $xNAME
    fi
}
