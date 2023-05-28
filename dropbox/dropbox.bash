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
	$xSUDO tar xjf "$file" -C "/opt/$xNAME"
	cd "/opt/$xNAME"
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
		BINARY="https://www.dropbox.com/download?dl=packages/ubuntu/${xNAME}_2020.03.04_$ARCH.deb"
	elif [[ $xARCH == "x86_64" ]]; then
		ARCH="amd64"
		BINARY="https://www.dropbox.com/download?dl=packages/ubuntu/${xNAME}_${xVERSION}_$ARCH.deb"
	else
		install_any
		return
	fi

	local file
	file="$($XPM get "$BINARY" --no-progress --no-user-agent)"
	$xSUDO dpkg -i "$file"
}

remove_apt() {
	$xSUDO apt-get remove -y "$xNAME"
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
	file="$($XPM get "$BINARY" --no-progress --no-user-agent)"
	$1 "$file"
}

install_flatpak() {
	$1 install flathub com.dropbox.Client
}

remove_flatpak() {
	$1 remove com.dropbox.Client
}