#!/usr/bin/env bash
# shellcheck disable=SC2034
# USE THIS FILE AS TEMPLATE FOR YOUR SCRIPT

readonly xNAME="micro"
readonly xVERSION="2.0.11"
readonly xTITLE="Micro Text Editor"
readonly xDESC="A modern and intuitive terminal-based text editor"
readonly xURL="https://micro-editor.github.io"
readonly xARCH=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="https://raw.githubusercontent.com/zyedidia/micro/v$xVERSION/LICENSE"
readonly xPROVIDES=("micro")

# Here you can inform if this package is well-known to some package manager and is installed using xNAME
# it is good for batch install and remove, when informed here, you can safely remove install_(PM here)
# and remove_(PM here) function. Example: readonly xDEFAULT='apt' let you remove install_apt and remove_apt
readonly xDEFAULT=('apt' 'pacman' 'dnf' 'choco' 'brew' 'termux')

# variables which is dinamically set and available for use
# $yCHANNEL
#  the default channel is empty, which means the latest stable version
#  user can change using -c or --channel flag
# $isSnap, $isFlatpack, $isAppimage
#  these boolean variables are set to true if the package manager is available and selected
# $XPM is the path to xpm executable
# $ySUDO is the sudo command, if available. Most commands already add sudo if available
# $yBIN is the path to first bin folder on PATH.

# the only required function is validate. install_any and remove_any are very important, but not required.
validate() { # $1 is the path to executable from $xPROVIDES (if defined) or $xNAME
	$1 --version
}

install_any() {
	# shellcheck disable=SC1090
	sh "$($XPM get https://getmic.ro --exec --no-progress --no-user-agent)"
	$XPM file bin $xNAME --sudo --exec
}

remove_any() {
	$XPM file unbin $xNAME --sudo --force
}

# apt update will be called before install_apt and remove_apt
install_apt() {    # $1 means an executable compatible with apt (Debian, Ubuntu)
	$1 install $xNAME # with -y, with sudo if available
}

remove_apt() {    # $1 means apt compatible, with sudo if available
	$1 remove $xNAME # with -y, with sudo if available
}

# pacman -Syu will be called before install_pacman and remove_pacman
install_pacman() { # $1 means an executable compatible with pacman (Arch Linux)
	$1 -S $xNAME      # with --noconfirm, with sudo if available
}

remove_pacman() { # $1 means pacman compatible
	$1 -R $xNAME     # with --noconfirm, with sudo if available
}

# dnf update will be called before install_dnf and remove_dnf
install_dnf() {    # $1 means an executable compatible with dnf (Fedora)
	$1 install $xNAME # with -y, with sudo if available
}

remove_dnf() {       # $1 means dnf compatible with -y, with sudo if available
	$1 remove -y $xNAME # with -y, with sudo if available
}

# update commands will be called before install_pack and remove_pack
install_pack() { # $1 means an executable compatible with snap, flatpack or appimage
	# $isSnap, $isFlatpack, $isAppimage are available as boolean
	# shellcheck disable=SC2154
	if [[ $isFlatpack == true ]]; then # actually micro is not available on flatpack
		# $1 install $xNAME                   # with --assumeyes
		return 1
	elif [[ $isAppimage == true ]]; then # actually micro is not available on appimage
		# $1 install $xNAME
		return 1
	else # snap
		$1 install $xNAME
	fi
}

remove_pack() {
	# $isSnap, $isFlatpack, $isAppimage are available as boolean
	# shellcheck disable=SC2154
	if [[ $isFlatpack == true ]]; then # actually micro is not available on flatpack
		# $1 uninstall $xNAME                 # with --assumeyes
		exit 1
	elif [[ $isAppimage == true ]]; then # actually micro is not available on appimage
		# rm -f ~/.local/share/appimagekit/$xNAME
		exit 1
	else
		$1 remove $xNAME
	fi
}

# choco update will be called before install_choco and remove_choco
install_choco() { # $1 means an executable compatible  with chocolatey (Windows)
	$1 install $xNAME
}

remove_choco() { # $1 means choco compatible with -y
	$1 remove $xNAME
}

# brew update will be called before install_brew and remove_brew
install_brew() { # $1 means an executable compatible with brew (macOS)
	$1 install $xNAME
}

remove_brew() {
	$1 remove $xNAME
}

install_zypper() {          # $1 means an executable compatible with zypper (openSUSE) or zypper with -y
	$1 install "$xNAME-editor" # with --non-interactive, with sudo if available
}

remove_zypper() {          # $1 means zypper compatible with -y
	$1 remove "$xNAME-editor" # with --non-interactive, with sudo if available
}

install_termux() { # $1 means an executable compatible with pkg (Termux Android) with -y
	$1 install $xNAME # with -y, with sudo if available
}

remove_termux() { # $1 means pkg compatible with -y
	$1 remove $xNAME # with -y, with sudo if available
}

install_swupd() {       # $1 means an executable compatible with swupd (Clear Linux), with -y, with sudo if available
	$1 bundle-add go-basic # we don't really need go, but it's just an example
	install_any
}

remove_swupd() { # $1 means swupd compatible with -y, with sudo if available
	$1 bundle-remove --orphans
	remove_any
}
