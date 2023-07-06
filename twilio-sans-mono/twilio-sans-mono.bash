#!/usr/bin/env bash
# shellcheck disable=SC2034 disable=SC2154 disable=SC2164 disable=SC2103 disable=SC2155

readonly xNAME="twilio-sans-mono"
readonly xVERSION="1.0.0"
readonly xTITLE="Twilio Sans Mono Typeface"
readonly xDESC="A distinct programming font designed to fit the needs of every developer"
readonly xURL="https://github.com/twilio/twilio-sans-mono"
readonly xARCHS=(any)
readonly xLICENSE="OFL1.1"
# The list of functions that use the default name (xNAME) on the package manager (for batch install)
readonly xDEFAULT=()

validate() {
	# check if the font is installed, if yes, return 0, otherwise return 1
	fc-list | grep -i "twilio-sans-mono" >/dev/null
}

install_any() {
	local release="$xURL/raw/main/Twilio-Sans-Mono.zip"
	local zip

	zip="$($XPM get "$release" --no-progress --no-user-agent)"
	# the otf files are inside a folder named "OTF"

	$xSUDO unzip -o "$zip" -d "/usr/share/fonts/$xNAME"

	$xSUDO fc-cache -f -v

	$xSUDO rm -rf "$zip"
}

remove_any() {
	$xSUDO rm -rf "/usr/share/fonts/$xNAME"
}
