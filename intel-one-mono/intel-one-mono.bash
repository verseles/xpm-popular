#!/usr/bin/env bash
# shellcheck disable=SC2034 disable=SC2154 disable=SC2164 disable=SC2103

readonly xNAME="intel-one-mono"
readonly xVERSION="1.2.0"
readonly xTITLE="Intel One Mono Typeface"
readonly xDESC="An expressive monospaced font family that's built with clarity, legibility, and the needs of developers in mind"
readonly xURL="https://github.com/intel/intel-one-mono"
readonly xARCHS=(any)
readonly xLICENSE="OFL1.1"
# The list of functions that use the default name (xNAME) on the package manager (for batch install)
readonly xDEFAULT=()

readonly channel
channel=$([[ $xCHANNEL == "ttf" ]] && echo "ttf" || echo "otf")

validate() {
	# check if the font is installed, if yes, return 0, otherwise return 1
	fc-list | grep -i "$xNAME" >/dev/null
}

install_any() {
	local release="$xURL/releases/download/V$xVERSION/$channel.zip"
	local zip

	zip="$($XPM get "$release" --no-progress --no-user-agent)"
	# the otf files are inside a folder named "otf"

	$xSUDO unzip -o "$zip" -d "/usr/share/fonts/$xNAME"

	$xSUDO fc-cache -f -v

	$xSUDO rm -rf "$zip"
}

remove_any() {
	$xSUDO rm -rf "/usr/share/fonts/$xNAME"
}


install_pacman() {
	$1 -S "$channel-intel-one-mono"
}

remove_pacman() {
	$1 -R "$channel-intel-one-mono"
}
