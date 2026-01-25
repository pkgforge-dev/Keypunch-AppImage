#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q keypunch-git | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/dev.bragefuglseth.Keypunch.Devel.svg
export DESKTOP=/usr/share/applications/dev.bragefuglseth.Keypunch.Devel.desktop
export STARTUPWMCLASS=dev.bragefuglseth.Keypunch.Devel # Default to Wayland's wmclass. For X11, GTK_CLASS_FIX will force the wmclass to be the Wayland one.
export GTK_CLASS_FIX=1

# Deploy dependencies
quick-sharun /usr/bin/keypunch

# Turn AppDir into AppImage
quick-sharun --make-appimage
