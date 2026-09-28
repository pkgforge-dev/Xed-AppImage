#!/bin/sh
set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q xed 2>/dev/null | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export DESKTOP=/usr/share/applications/org.x.editor.desktop
export ICON=/usr/share/help/C/xed/figures/xed_print_button.png
export APPNAME=Xed
export DEPLOY_PYTHON=1
export GTK_FIX_NONSENSE=1
USE_HOST_DRIVERS_EXPERIMENTAL=1

# Deploy dependencies
quick-sharun /usr/bin/xed /usr/lib/xed /usr/share/xed /usr/lib/libgtk-3.so*

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the AppImage
quick-sharun --test ./dist/*.AppImage
