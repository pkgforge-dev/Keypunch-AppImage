#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	blueprint-compiler \
	cargo              \
	graphene           \
	libadwaita         \
	meson              \
	ninja

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

echo "Building Keypunch..."
echo "---------------------------------------------------------------"
export LIBADWAITA_1_NO_PKG_CONFIG=1
export SYSTEM_DEPS_LIBADWAITA_1_NO_PKG_CONFIG=1
export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1
export SYSTEM_DEPS_LIBADWAITA_1_LIB=adwaita-1
export SYSTEM_DEPS_LIBADWAITA_1_SEARCH_NATIVE=/usr/lib
export RUSTUP_TOOLCHAIN=stable

git clone https://github.com/bragefuglseth/keypunch ./keypunch && (
	cd ./keypunch

	git fetch --tags origin
	TAG=$(git tag --sort=-v:refname | grep -vi 'rc\|alpha\|beta' | head -1)
	git checkout "$TAG"

	meson setup build --prefix=/usr --libdir=lib --buildtype=release
	meson compile -C build
	meson install -C build

	echo "$TAG" > ~/version
)
