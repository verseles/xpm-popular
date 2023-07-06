#!/usr/bin/env bash
# shellcheck disable=SC2034 disable=SC2154 disable=SC2164 disable=SC2103 disable=SC2155

readonly xNAME="recursive-sans-mono"
readonly xVERSION="1.085"
readonly xTITLE="Recursive Sans & Mono"
readonly xDESC="A typographic palette for vibrant code & UI"
readonly xURL="https://github.com/arrowtype/recursive"
readonly xARCHS=(any)
readonly xLICENSE="OFL1.1"
# The list of functions that use the default name (xNAME) on the package manager (for batch install)
readonly xDEFAULT=()

validate() {
	# check if the font is installed, if yes, return 0, otherwise return 1
	fc-list | grep -i "recursive" >/dev/null
}

install_any() {
	local release="$xURL/releases/download/v$xVERSION/ArrowType-Recursive-$xVERSION.zip"
	local zip

	zip="$($XPM get "$release" --no-progress --no-user-agent)"

	$xSUDO unzip -o "$zip" -d "/usr/share/fonts/$xNAME"

	$xSUDO fc-cache -f -v

	$xSUDO rm -rf "$zip"
}

remove_any() {
	$xSUDO rm -rf "/usr/share/fonts/$xNAME"
}
