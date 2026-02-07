#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano mesa-zink ! llvm-libs

echo "Building Keypunch..."
echo "---------------------------------------------------------------"
wget --retry-connrefused --tries=30 https://raw.githubusercontent.com/archlinuxcn/repo/refs/heads/master/archlinuxcn/keypunch-git/PKGBUILD -O ./PKGBUILD
make-aur-package
