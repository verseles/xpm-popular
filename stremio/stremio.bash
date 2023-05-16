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

install_any() {
    # local file
    # file="$($XPM get "http://archive.mozilla.org/pub/firefox/releases/$xVERSION/linux-x86_64/en-US/firefox-$xVERSION.tar.bz2" --no-progress --no-user-agent --name="$xNAME-$xVERSION.tar.bz2")"
    # $ySUDO mkdir -p "/opt/$xNAME"
    # $ySUDO tar xvf "$file" -C "/opt"
    # $ySUDO ln -sf "/opt/$xNAME/$xNAME" "$yBIN/$xNAME"
    # $XPM shortcut --name="$xNAME" --path="$xNAME" --icon="/opt/$xNAME/browser/chrome/icons/default/default128.png" --description="$xDESC" --category="Network"
}

remove_any() {
    # $ySUDO rm -rf "/opt/$xNAME"
    # $ySUDO rm -f "$yBIN/$xNAME"
    # $XPM shortcut --remove --name="$xNAME"
}

install_apt() {
    local file
    file="$($XPM get "https://dl.strem.io/shell-linux/v$xVERSION/$xNAME_$xVERSION-1_amd64.deb" --no-progress --no-user-agent --name="$xNAME-$xVERSION.deb")"
    $ySUDO dpkg -i "$file"
    $1 install -f
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
