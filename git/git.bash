#!/usr/bin/env bash
# shellcheck disable=SC2034
# USE THIS FILE AS TEMPLATE FOR YOUR SCRIPT

readonly xNAME="git"
readonly xVERSION="2.40.1"
readonly xTITLE="Git"
readonly xDESC="A distributed version control system"
readonly xURL="https://git-scm.com"
readonly xARCH=('linux64' 'linux32' 'linux-arm' 'linux-arm64' 'macos-arm64' 'macos' 'win32' 'win64' 'freebsd64' 'freebsd32' 'openbsd64' 'openbsd32' 'netbsd64' 'netbsd32')
readonly xLICENSE="https://raw.githubusercontent.com/git/git/v$xVERSION/COPYING"
readonly xPROVIDES=("git")
# The list of functions that use the default name (xNAME) on the package manager (for batch install)
readonly xDEFAULT=('apt' 'pacman' 'dnf' 'choco' 'brew' 'zypper' 'emerge' 'urpmi' 'alpine' 'nix' 'termux' 'swupd')

# the only required function is validate. install_any and remove_any are very important, but not required.
validate() { # $1 is the path to executable from $xPROVIDES (if defined) or $xNAME
	$1 --version
}

install_any() {
	local git git_install_dir
	git=$($XPM get https://www.kernel.org/pub/software/scm/git/git-$xVERSION.tar.xz --no-progress --name=git.tar.xz)
	tar -xvf "$git"
	cd git-* || exit
	git_install_dir=$(pwd)
	make configure
	./configure --prefix="${yBIN/%\/bin/}"
	make
	$ySUDO make install
	cd .. || exit
	$XPM file delete -rf "$git" "$git_install_dir"
}

remove_any() {
	$XPM file unbin "$yBIN/$xNAME" --sudo --force
}
