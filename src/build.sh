#!/bin/sh
set -e


# Build NixOS system
echo "Building NixOS system for Raspberry Pi 5..."
cd /src && nix build .#packages.aarch64-linux.default  --refresh

# Copy distro image to distribution folder
IMAGE_NAME="nixos-sd-image-rpi5-kernelboot.img.zst"
RESULT_IMAGE="$(readlink -f /src/result)/sd-image/$IMAGE_NAME"

cp "$RESULT_IMAGE" /dist/distro.img.zst
