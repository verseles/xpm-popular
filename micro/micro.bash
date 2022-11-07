#!/usr/bin/env bash

readonly xCHANNEL="stable"
readonly xNAME="micro"
readonly xVERSION="2.0.11"
readonly xTITLE="Micro Text Editor"
readonly xDESC="A modern and intuitive terminal-based text editor"
readonly xURL="https://micro-editor.github.io"
readonly xARCH=('x86_64' 'i686' 'armv6h' 'armv7h' 'aarch64')
readonly xLICENSE="https://raw.githubusercontent.com/zyedidia/micro/v$xVERSION/LICENSE"

install_debian() {
	$1 install -y $xNAME
}

remove_debian() {
	$ remove $xNAME
}

install_archlinux() {
	$1 -S --noconfirm $xNAME
}

uninstall_archlinux() {
	$1 -R --noconfirm $xNAME
}

update_archlinux() {
	$1 -Syu --noconfirm $xNAME
}

install_others() {
	curl https://getmic.ro | bash
}

validate() {
	$1 --version
}
