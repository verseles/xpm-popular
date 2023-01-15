#!/usr/bin/env bash
# shellcheck disable=SC2034

readonly xCHANNEL="stable"
readonly xNAME="micro"
readonly xVERSION="2.0.11"
readonly xTITLE="Micro Text Editor"
readonly xDESC="A modern and intuitive terminal-based text editor"
readonly xURL="https://micro-editor.github.io"
readonly xARCH=('x86_64' 'i686' 'armv6h' 'armv7h' 'aarch64')
readonly xLICENSE="https://raw.githubusercontent.com/zyedidia/micro/v$xVERSION/LICENSE"
readonly xPROVIDES=("micro")
yBETA=false # will be true if request a beta version
yDEV=false  # will be true if request a dev/alpha version
# @TODO if a method is equal to true, assume the default command using $xNAME as the package name (e.g. apt install $xNAME)

# optional methods install_debian, remove_debian, install_archlinux, uninstall_archlinux, install_fedora, remove_fedora, install_snap, remove_snap, install_appimage, remove_appimage, install_centos, remove_centos

install_any() {
	cd /usr/local/bin/ || exit 1
	GETMICRO_REGISTER=yes bash <(curl -sL https://getmic.ro)
}

remove_any() {
	rm -rf /usr/local/bin/micro
}

install_apt() { # $1 means an executable compatible with apt (Debian, Ubuntu)
	$1 install -y $xNAME
}

remove_apt() {
	$1 remove $xNAME
}

install_pacman() { # $1 means an executable compatible with pacman (Arch Linux)
	$1 -S --noconfirm $xNAME
}

remove_pacman() {
	$1 -R --noconfirm $xNAME
}

install_dnf() { # $1 means an executable compatible with dnf (Fedora)
	$1 install -y $xNAME
}

remove_dnf() {
	$1 remove -y $xNAME
}

install_pack() { # $1 means an executable compatible with snap, flatpack or appimage
	$1 install $xNAME
}

remove_pack() {
	$1 remove $xNAME
}

install_yum() { # $1 means an executable compatible with yum (CentOS)
	$1 install -y $xNAME
}

remove_yum() {
	$1 remove -y $xNAME
}

install_choco() { # $1 means an executable compatible with chocolatey (Windows)
	$1 install $xNAME
}

remove_choco() {
	$1 remove $xNAME
}

install_brew() { # $1 means an executable compatible with brew (macOS)
	$1 install $xNAME
}

remove_brew() {
	$1 remove $xNAME
}

install_zypper() { # $1 means an executable compatible with zypper (openSUSE)
	$1 install -y $xNAME
}

remove_zypper() {
	$1 remove -y $xNAME
}

install_android() { # $1 means an executable compatible with pkg (Termux Android)
	$1 install $xNAME
}

remove_android() {
	$1 remove $xNAME
}

validate() { # $1 is the path to executable from $xNAME or $xPROVIDES (if defined)
	$1 --version
}
