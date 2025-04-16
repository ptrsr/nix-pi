#!/bin/sh
set -e

TARGET="${TARGET:-pi}"

echo "Copying flake and lock..."
cp -f "/src/targets/${TARGET}/flake."{nix,lock}  "/src/"

echo "Building NixOS system for target '${TARGET}'..."
cd /src && nix build .#image

# IMG="$(readlink -f /src/result)/sd-image"/*.img.zst
# cp "$IMG" "/dist/distro-${TARGET}.img.zst"

# Try the Nix-style resolved path first
IMG_DIR="$(readlink -f /src/result)/sd-image"
IMG=$(find "$IMG_DIR" -maxdepth 1 -name "*.img.zst" -print -quit)

# Fallback to original path if nothing found
if [[ ! -f "$IMG" ]]; then
  IMG_DIR="/src/result/sd-image"
  IMG=$(find "$IMG_DIR" -maxdepth 1 -name "*.img.zst" -print -quit)
fi

# Check again before copying
if [[ -f "$IMG" ]]; then
  cp "$IMG" "/dist/distro-${TARGET}.img.zst"
else
  echo "Error: No .img.zst image found in either resolved or original path."
  exit 1
fi