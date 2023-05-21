#!/usr/bin/env bash
# shellcheck disable=SC2034

readonly xCHANNEL="stable"
readonly xNAME="rclone"
readonly xVERSION="1.60.0"
readonly xTITLE="rclone"
readonly xDESC="Sync files to and from Google Drive, S3, Swift, Cloudfiles, Dropbox and Google Cloud Storage"
readonly xURL="https://rclone.org"
readonly xARCHS=('x86_64' 'armv6h' 'armv7h' 'aarch64')
readonly xLICENSE="https://raw.githubusercontent.com/$xNAME/$xNAME/master/COPYING"
readonly xPROVIDES=("rclone")

install_any() {
	curl -sL https://rclone.org/install.sh | sudo bash
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

install_pack() { # $1 means an executable compatible with snap, flatpack
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
