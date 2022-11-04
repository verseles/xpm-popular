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

readonly xDOWNLOAD_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"

readonly xDEPENDS=""

#install_debian() {
#
#}

#remove_debian() {
#	#	$XPM remove google-chrome-stable
#}

install_archlinux() {
	$xAUR google-chrome
}

uninstall_archlinux() {
	$xAUR -R google-chrome
}

validate() {
	# Test the installation
	echo validating...
	"$xNAME-$xCHANNEL" --version
}

validate

echo script end
