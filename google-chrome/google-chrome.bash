#!/usr/bin/env bash
echo script start

readonly xCHANNEL="stable"
readonly xNAME="google-chrome"
readonly xVERSION="87.0.4280.88"
readonly xTITLE="Google Chrome"
readonly xDESC="The popular and trusted web browser by Google (Stable Version)"
readonly xURL="https://www.google.com/chrome/"
readonly xARCH=('x86_64')
readonly xLICENCE="https://www.google.com/chrome/terms/"

install_debian() {
	$1 install -y "$xNAME-$xCHANNEL"
}

remove_debian() {
	$ remove google-chrome-stable
}

install_archlinux() {
	$1 google-chrome
}

uninstall_archlinux() {
	$1 -R google-chrome
}

validate() {
	# Test the installation
	echo validating...
	"$xNAME-$xCHANNEL" --version
}
