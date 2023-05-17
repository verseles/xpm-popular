#!/usr/bin/env bash
# shellcheck disable=SC2034
# USE THIS FILE AS TEMPLATE FOR YOUR SCRIPT

readonly xNAME="xpm"
readonly xVERSION="0.30.0"
readonly xTITLE="xpm"
readonly xDESC="Universal package manager for any unix-like distro, including macOS and Android"
readonly xURL="https://xpm.link"
readonly xARCHS=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="https://raw.githubusercontent.com/verseles/$xNAME/v$xVERSION/LICENSE"
readonly xPROVIDES=('xpm')
# The list of functions that use the default name (xNAME) on the package manager (for batch install)
readonly xDEFAULT=()
# only for xpm, not for package manager
readonly xREQUIRES=('git')
readonly xCONFLICTS=()

# variables which is dinamically set and available for use
# $xCHANNEL
#  the default channel is empty, which means the latest stable version
#  user can change using -c or --channel flag
# $hasSnap, $isFlatpack, $hasAppImage
#  these boolean variables are set to true if the package manager is available and selected
# $XPM is the path to xpm executable
# $xSUDO is the sudo command, if available. Most commands already add sudo if available

# the only required function is validate. install_any and remove_any are very important, but not required.
validate() { # $1 is the path to executable from $xPROVIDES (if defined) or $xNAME
	$1 --version
}

install_any() {
	# shellcheck disable=SC1090
	sh "$($XPM get https://xpm.link --exec --no-progress --no-user-agent)"
}

remove_any() {
	$XPM file unbin $xNAME --sudo --force
}
