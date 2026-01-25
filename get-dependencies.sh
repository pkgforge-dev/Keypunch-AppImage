#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ! llvm-libs

echo "Building Keypunch..."
echo "---------------------------------------------------------------"
make-aur-package --archlinuxcn keypunch-git
