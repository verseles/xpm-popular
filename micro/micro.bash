#!/usr/bin/env bash
# shellcheck disable=SC2034
# USE THIS FILE AS TEMPLATE FOR YOUR SCRIPT

readonly xNAME="micro"
readonly xVERSION="2.0.11"
readonly xTITLE="Micro Text Editor"
readonly xDESC="A modern and intuitive terminal-based text editor"
readonly xURL="https://micro-editor.github.io"
readonly xLICENSE="https://raw.githubusercontent.com/zyedidia/micro/v$xVERSION/LICENSE"
readonly xPROVIDES=("micro")
declare -r xARCH=(
	[linux_x86_64]=linux64
	[linux_i386]=linux32
	[linux_armv7l]=linux-arm
	[linux_aarch64]=linux-arm64
	[darwin_arm64]=macos-arm64
	[darwin_x86_64]=macos
	[win32]=win32
	[win64]=win64
	[freebsd_x86_64]=freebsd64
	[freebsd_i386]=freebsd32
	[openbsd_x86_64]=openbsd64
	[openbsd_i386]=openbsd32
	[netbsd_x86_64]=netbsd64
	[netbsd_i386]=netbsd32
) # xARCH is a map of supported architectures [os_arch]=url_arch

# variables which is dinamically set
# $yCHANNEL
#  the default channel is empty, which means the latest stable version
#  user can change using -c or --channel flag
# $isSnap, $isFlatpack, $isAppimage
#  only when using snap, flatpack or appimage, these variables are available as boolean
# $XPM is the path to xpm executable
# $yARCH is the architecture of the current system

# optional methods install_apt, remove_apt, install_pacman, remove_pacman, install_dnf, remove_dnf, install_pack, remove_pack, install_yum, remove_yum, install_choco, remove_choco, install_brew, remove_brew, install_zypper, remove_zypper, install_android, remove_android, validate
validate() { # $1 is the path to executable from $xPROVIDES (if defined) or $xNAME
	$1 --version
}
install_any() { # soon we will have a cross-platform command to get files and checksum
	# shellcheck disable=SC2046
	local installer
	installer=$($XPM get https://getmic.ro --exec)
	sh "$installer"
	$XPM file bin $xNAME --sudo --exec
}

remove_any() {
	$XPM file unbin $xNAME --sudo --force
}

install_apt() {    # $1 means an executable compatible with apt (Debian, Ubuntu)
	$1 install $xNAME # with -y
}

remove_apt() {    # $1 means apt compatible
	$1 remove $xNAME # with -y
}

install_pacman() { # $1 means an executable compatible with pacman (Arch Linux)
	$1 -S $xNAME      # with --noconfirm
}

remove_pacman() { # $1 means pacman compatible
	$1 -R $xNAME     # with --noconfirm
}

install_dnf() {    # $1 means an executable compatible with dnf (Fedora)
	$1 install $xNAME # with -y
}

remove_dnf() { # $1 means dnf compatible with -y
	$1 remove -y $xNAME
}

install_pack() { # $1 means an executable compatible with snap, flatpack or appimage
	# $isSnap, $isFlatpack, $isAppimage are available as boolean
	# shellcheck disable=SC2154
	if [[ $isFlatpack == true ]]; then   # actually micro is not available on flatpack
		$1 install $xNAME                   # with --assumeyes
	elif [[ $isAppimage == true ]]; then # actually micro is not available on appimage
		$1 install $xNAME
	else
		$1 install $xNAME
	fi
}

remove_pack() {
	# $isSnap, $isFlatpack, $isAppimage are available as boolean
	# shellcheck disable=SC2154
	if [[ $isFlatpack == true ]]; then   # actually micro is not available on flatpack
		$1 uninstall $xNAME                 # with --assumeyes
	elif [[ $isAppimage == true ]]; then # actually micro is not available on appimage
		rm -f ~/.local/share/appimagekit/$xNAME
	else
		$1 remove $xNAME
	fi
}

install_yum() {    # $1 means an executable compatible with yum (CentOS). Prefers dnf.
	$1 install $xNAME # $1 with -y
}

remove_yum() { # $1 means yum compatible with -y
	$1 remove -y $xNAME
}

install_choco() {  # $1 means an executable compatible  with chocolatey (Windows)
	$1 install $xNAME # with -y
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
	$1 install $xNAME
}

remove_zypper() { # $1 means zypper compatible with -y
	$1 remove -y $xNAME
}

install_android() { # $1 means an executable compatible with pkg (Termux Android) with -y
	$1 install $xNAME
}

remove_android() { # $1 means pkg compatible with -y
	$1 remove $xNAME
}
