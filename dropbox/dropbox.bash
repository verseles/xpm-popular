#!/usr/bin/env bash
# shellcheck disable=SC2034 disable=SC2154 disable=SC2164 disable=SC2103

readonly xNAME="dropbox"
readonly xVERSION="2022.12.05"
readonly xTITLE="Dropbox"
readonly xDESC="File hosting service that offers cloud storage, file synchronization, personal cloud, and client software"
readonly xURL="https://dropbox.com"
readonly xARCHS=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE=""
readonly xPROVIDES=()
# The list of functions that use the default name (xNAME) on the package manager (for batch install)
# Once you define this, there is no need to create a specfic function for mentioned package manager.
readonly xDEFAULT=('brew' 'pacman')

readonly xREQUIRES=()
readonly xCONFLICTS=()

validate() { # $1 is the path to executable from $xPROVIDES (if defined) or $xNAME
	$1
}

install_any() {
	local SOURCE="https://linux.dropbox.com/packages/nautilus-dropbox-2022.12.05.tar.bz2"
	local file
	file="$($XPM get "$SOURCE" --no-progress --no-user-agent)"
	$xSUDO mkdir -p "/opt/$xNAME"
	cd "/opt/$xNAME"
	$xSUDO tar xjf "$file" -C "/opt/$xNAME"
	cd nautilus-dropbo*
	./configure
	make
	$xSUDO make install
}

remove_any() {
	cd "/opt/$xNAME"
	$xSUDO make uninstall
	$xSUDO rm -rf "/opt/$xNAME"
}

install_apt() {
	local ARCH
	local BINARY
	if [[ $xARCH == "x86" ]]; then
		ARCH="i386"
		BINARY="https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_$ARCH.deb"
	elif [[ $xARCH == "x86_64" ]]; then
		ARCH="amd64"
		BINARY="https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_${xVERSION}_$ARCH.deb"
	else
		install_any
		return
	fi
	$XPM log info "Downloading $BINARY"
	local file
	file="$($XPM get "$BINARY" --no-progress --no-user-agent --name="$xNAME-$xVERSION-$ARCH.deb")"
	$xSUDO dpkg --ignore-depends=libpango1.0-0 --ignore-depends=libgtk-4-1 --ignore-depends=gir1.2-gtk-4.0 -i "$file"
}

remove_apt() {
	if [[ $xARCH == "x86" || $xARCH == "x86_64" ]]; then
		$xSUDO apt-get remove $xNAME
	else
		remove_any
		return
	fi
}

install_dnf() {
	local ARCH
	local BINARY

	if [[ $xARCH == "x86" ]]; then
		ARCH="i386"
		BINARY="https://www.dropbox.com/download?dl=packages/fedora/nautilus-dropbox-2020.03.04-1.fedora.$ARCH.rpm"
	elif [[ $xARCH == "x86_64" ]]; then
		ARCH="x86_64"
		BINARY="https://www.dropbox.com/download?dl=packages/fedora/nautilus-dropbox-$xVERSION-1.fedora.$ARCH.rpm"
	else
		install_any
		return
	fi
	local file
	file="$($XPM get "$BINARY" --no-progress --no-user-agent --name="$xNAME-$xVERSION-$ARCH.rpm")"
	$1 install "$file"
}

remove_dnf() {
	if [[ $xARCH == "x86" || $xARCH == "x86_64" ]]; then
		$1 remove "nautilus-dropbox"
	else
		remove_any
		return
	fi
}

install_flatpak() {
	echo "$1 install flathub com.dropbox.Client"
	$1 install flathub com.dropbox.Client
}

remove_flatpak() {
	$1 remove com.dropbox.Client
}

install_swupd() {
	$1 bundle-add -y desktop -W4
	flatpak -y --noninteractive install flathub com.dropbox.Client
}

remove_swupd() {
	flatpak -y --noninteractive remove com.dropbox.Client
}
