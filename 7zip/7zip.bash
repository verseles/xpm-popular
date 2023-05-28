#!/usr/bin/env bash
# shellcheck disable=SC2034 disable=SC2154 disable=SC2164 disable=SC2103

readonly xNAME="7zip"
readonly xVERSION="23.00"
readonly xTITLE="7-Zip"
readonly xDESC="A free and open-source file archiver utility for compressing and uncompressing files"
readonly xURL="https://www.7-zip.org"
readonly xARCHS=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="LGPL"
readonly xPROVIDES=('7zzs' '7zz' '7za' '7zr')
# The list of functions that use the default name (xNAME) on the package manager (for batch install)
readonly xDEFAULT=()

readonly xREQUIRES=()
readonly xCONFLICTS=()

validate() { # $1 is the path to executable from $xPROVIDES (if defined) or $xNAME
	$1
}

install_any() {

	echo $xARCH
	exit 1
	local OS
	local VERSION
	local ARCH
	VERSION=${xVERSION//./}
	if [[ $xOS == "macos" ]]; then
		OS="macos"
		ARCH=""
	else
		OS="$xOS"
		ARCH="$xARCH"
	fi
	local binary="https://7-zip.org/a/7z$VERSION-$OS$ARCH.tar.xz"
}
