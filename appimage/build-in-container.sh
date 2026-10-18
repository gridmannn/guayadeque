#!/bin/bash
# Runs inside the appimage/Dockerfile container. /src is the source tree, /out receives the AppImage.
set -euo pipefail

BUILD_DIR=/tmp/build
APPDIR=/tmp/AppDir

cmake -S /src -B "$BUILD_DIR" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_CXX_STANDARD=11 \
    -D_GUREVISION_="${GUREVISION:-unknown}"
make -C "$BUILD_DIR" -j"$(nproc)"
make -C "$BUILD_DIR" install DESTDIR="$APPDIR"

export DEPLOY_GTK_VERSION=3
export GSTREAMER_PLUGINS_DIR=/usr/lib/x86_64-linux-gnu/gstreamer-1.0
export GSTREAMER_HELPERS_DIR=/usr/lib/x86_64-linux-gnu/gstreamer1.0/gstreamer-1.0
export GSTREAMER_INCLUDE_BAD_PLUGINS=1
export LDAI_OUTPUT="Guayadeque-${GUREVISION:-unknown}-x86_64.AppImage"

cd /out
linuxdeploy-x86_64.AppImage \
    --appdir "$APPDIR" \
    --desktop-file "$APPDIR/usr/share/applications/guayadeque.desktop" \
    --icon-file "$APPDIR/usr/share/pixmaps/guayadeque.png" \
    --plugin gtk \
    --plugin gstreamer \
    --output appimage

chown "${HOST_UID:-0}:${HOST_GID:-0}" "/out/$LDAI_OUTPUT"
