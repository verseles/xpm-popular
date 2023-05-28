#!/usr/bin/env bash
# shellcheck disable=SC2034
# USE THIS FILE AS TEMPLATE FOR YOUR SCRIPT

readonly xNAME="7zip"
readonly xVERSION="22.01"
readonly xTITLE="7-Zip"
readonly xDESC="A free and open-source file archiver utility for compressing and uncompressing files"
readonly xURL="https://www.7-zip.org"
readonly xARCHS=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="LGPLv2"
readonly xPROVIDES=('7z' '7za' '7zr')
# The list of functions that use the default name (xNAME) on the package manager (for batch install)
readonly xDEFAULT=()

readonly xREQUIRES=()
readonly xCONFLICTS=()

validate() { # $1 is the path to executable from $xPROVIDES (if defined) or $xNAME
	$1
}

install_pacman() {
	$1 -S 7-zip-full
}

remove_pacman() {
	$1 -R 7-zip-full
}

