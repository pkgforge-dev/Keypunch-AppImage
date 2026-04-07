#!/bin/sh

set -eu

ARCH=$(uname -m)

pacman -Syu --noconfirm pkgconf libadwaita

echo "TEST------------------------------------------------------TEST"
pkg-config --modversion libadwaita-1
echo "TEST------------------------------------------------------TEST"

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Building Keypunch..."
echo "---------------------------------------------------------------"
wget --retry-connrefused --tries=30 https://raw.githubusercontent.com/archlinuxcn/repo/refs/heads/master/archlinuxcn/keypunch-git/PKGBUILD -O ./PKGBUILD
make-aur-package
