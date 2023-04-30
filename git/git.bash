#!/usr/bin/env bash
# shellcheck disable=SC2034
# USE THIS FILE AS TEMPLATE FOR YOUR SCRIPT

readonly xNAME="git"
readonly xVERSION="2.35.1"
readonly xTITLE="Git"
readonly xDESC="A distributed version control system"
readonly xURL="https://git-scm.com"
readonly xARCH=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="https://raw.githubusercontent.com/git/git/v$xVERSION/COPYING"
readonly xPROVIDES=("git")
# The list of functions that use the default name (xNAME) on the package manager (for batch install)
readonly xDEFAULT=('apt' 'pacman' 'dnf')

# variables which are dynamically set and available for use
# $yCHANNEL
#  the default channel is empty, which means the latest stable version
#  user can change using -c or --channel flag
# $isSnap, $isFlatpack, $isAppimage
#  these boolean variables are set to true if the package manager is available and selected
# $XPM is the path to xpm executable
# $ySUDO is the sudo command, if available. Most commands already add sudo if available

# the only required function is validate. install_any and remove_any are very important, but not required.
validate() { # $1 is the path to executable from $xPROVIDES (if defined) or $xNAME
	$1 --version
}

install_any() {
	# shellcheck disable=SC1090
	$XPM file bin $xNAME --sudo --exec
}

remove_any() {
	$XPM file unbin $xNAME --sudo --force
}

install_pacman() { # $1 means an executable compatible with pacman (Arch Linux)
	$1 -S $xNAME      # with --noconfirm, with sudo if available
}

remove_pacman() { # $1 means pacman compatible
	$1 -R $xNAME     # with --noconfirm, with sudo if available
}

install_dnf() {    # $1 means an executable compatible with dnf (Fedora)
	$1 install $xNAME # with -y, with sudo if available
}

remove_dnf() {       # $1 means dnf compatible with -y, with sudo if available
	$1 remove -y $xNAME # with -y, with sudo if available
}

install_choco() { # $1 means an executable compatible  with chocolatey (Windows)
	$1 install $xNAME
}

remove_choco() { # $1 means choco compatible with -y
	$1 remove $xNAME
}

install_brew() { # $1 means an executable compatible with brew (macOS)
	$1 install $xNAME
}

remove_brew() {
	$1 remove $xNAME
}

install_zypper() { # $1 means an executable compatible with zypper (openSUSE) or zypper with -y
	$1 install $xNAME # with --non-interactive, with sudo if available
}

remove_zypper() { # $1 means zypper compatible with -y
	$1 remove $xNAME # with --non-interactive, with sudo if available
}

install_android() { # $1 means an executable compatible with pkg (Termux Android) with -y
	$1 install $xNAME  # with -y, with sudo if available
}

remove_android() { # $1 means pkg compatible with -y
	$1 remove $xNAME  # with -y, with sudo if available
}

install_swupd() {        # $1 means an executable compatible with swupd (Clear Linux), with -y, with sudo if available
	$1 bundle-add dev-utils # we don't really need dev-utils, but it's just an example
	install_any
}

remove_swupd() { # $1 means swupd compatible with -y, with sudo if available
	$1 bundle-remove --orphans
	remove_any
}