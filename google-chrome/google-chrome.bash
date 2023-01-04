#!/usr/bin/env bash
# shellcheck disable=SC2034

# EXAMPLE OUT-OF-DATE, CHECK micro/micro.bash FOR MOST RECENT EXAMPLE
# EXAMPLE OUT-OF-DATE, CHECK micro/micro.bash FOR MOST RECENT EXAMPLE
# EXAMPLE OUT-OF-DATE, CHECK micro/micro.bash FOR MOST RECENT EXAMPLE
# EXAMPLE OUT-OF-DATE, CHECK micro/micro.bash FOR MOST RECENT EXAMPLE
# EXAMPLE OUT-OF-DATE, CHECK micro/micro.bash FOR MOST RECENT EXAMPLE

readonly xCHANNEL="stable"
readonly xNAME="google-chrome"
readonly xVERSION="87.0.4280.88"
readonly xTITLE="Google Chrome"
readonly xDESC="The popular and trusted web browser by Google (Stable Version)"
readonly xURL="https://www.google.com/chrome/"
readonly xARCH=('x86_64')
readonly xLICENSE="https://www.google.com/chrome/terms/"

install_debian() {
	$1 install -y "$xNAME-$xCHANNEL"
}

remove_debian() {
	$ remove "$xNAME-$xCHANNEL"
}

install_archlinux() {
	$1 -S --noconfirm "$xNAME-$xCHANNEL"
}

uninstall_archlinux() {
	$1 -R --noconfirm "$xNAME-$xCHANNEL"
}

update_archlinux() {
	$1 -Syu --noconfirm "$xNAME-$xCHANNEL"
}

install_any() {
	echo "Not implemented"
}

validate() {
	# Test the installation
	echo validating...
	"$xNAME-$xCHANNEL" --version
}
