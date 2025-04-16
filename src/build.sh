#!/bin/sh
set -e

TARGET="${TARGET:-pi}"

echo "Building NixOS system for target '${TARGET}'..."
cd /src && nix build ./targets/${TARGET}#image

IMG="$(readlink -f /src/result)/sd-image"/*.img.zst
cp "$IMG" "/dist/distro-${TARGET}.img.zst"
