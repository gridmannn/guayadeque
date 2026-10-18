#!/bin/bash
# Builds Guayadeque-<rev>-x86_64.AppImage in the repository root using Docker.
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/.."

docker build -t guayadeque-appimage appimage
docker run --rm \
    -v "$PWD:/src:ro" \
    -v "$PWD:/out" \
    -e GUREVISION="$(git log -1 --format=%h)" \
    -e HOST_UID="$(id -u)" -e HOST_GID="$(id -g)" \
    guayadeque-appimage bash /src/appimage/build-in-container.sh
