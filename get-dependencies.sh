#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Building Keypunch..."
echo "---------------------------------------------------------------"

wget --retry-connrefused --tries=30 https://raw.githubusercontent.com/archlinuxcn/repo/refs/heads/master/archlinuxcn/keypunch-git/PKGBUILD -O ./PKGBUILD

export LIBADWAITA_1_NO_PKG_CONFIG=1
export SYSTEM_DEPS_LIBADWAITA_1_NO_PKG_CONFIG=1
export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1
export SYSTEM_DEPS_LIBADWAITA_1_LIB=adwaita-1
export SYSTEM_DEPS_LIBADWAITA_1_SEARCH_NATIVE=/usr/lib
make-aur-package
