# Build environment for the Guayadeque AppImage.
# Ubuntu 22.04 keeps the glibc baseline old enough for most current distros.
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential cmake pkg-config gettext git file wget ca-certificates \
        libwxgtk3.0-gtk3-dev libwxsqlite3-3.0-dev \
        libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
        libtag1-dev libsqlite3-dev libcurl4-gnutls-dev libdbus-1-dev \
        libgdk-pixbuf2.0-dev libglib2.0-dev libjsoncpp-dev libgpod-dev \
        gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav \
        gstreamer1.0-pulseaudio gstreamer1.0-alsa \
        librsvg2-common gtk-update-icon-cache \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/tools
RUN wget -q https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage \
    && wget -q https://raw.githubusercontent.com/linuxdeploy/linuxdeploy-plugin-gtk/master/linuxdeploy-plugin-gtk.sh \
    && wget -q https://raw.githubusercontent.com/linuxdeploy/linuxdeploy-plugin-gstreamer/master/linuxdeploy-plugin-gstreamer.sh \
    && chmod +x linuxdeploy-x86_64.AppImage linuxdeploy-plugin-*.sh

# No FUSE inside the container
ENV APPIMAGE_EXTRACT_AND_RUN=1
ENV PATH=/opt/tools:$PATH
