#!/bin/sh
set -e

TARGET="${TARGET:-pi}"

echo "Copying flake and lock..."
cp -f "/src/targets/${TARGET}/flake."{nix,lock}  "/src/"

echo "Building NixOS system for target '${TARGET}'..."
cd /src && nix build .#image

IMG="$(readlink -f /src/result)/sd-image"/*.img.zst
cp "$IMG" "/dist/distro-${TARGET}.img.zst"
