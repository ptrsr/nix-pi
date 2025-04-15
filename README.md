# NixOS Raspberry Pi Image Builder

This repository contains the configuration and build scripts to create a custom NixOS image for Raspberry Pi using Docker.

## Prerequisites

- Docker installed on your system
- At least 8GB of free disk space
- A Raspberry Pi SD card (8GB or larger recommended)

## Building the Image

1. Build the Docker image:
   ```bash
   docker build -t nixos-pi-builder .
   ```

2. Run the build process:
   ```bash
   docker run -v $(pwd):/build nixos-pi-builder
   ```

This will create a file named `nixos-sd-image.img` in your current directory.

## Flashing the Image

To flash the image to your SD card:

1. Identify your SD card device (e.g., `/dev/sdb`):
   ```bash
   lsblk
   ```

2. Flash the image (replace `/dev/sdX` with your SD card device):
   ```bash
   sudo dd if=nixos-sd-image.img of=/dev/sdX bs=4M status=progress
   ```

3. Sync the writes:
   ```bash
   sudo sync
   ```

## Configuration

The main configuration is in `configuration.nix`. You can modify this file to customize your NixOS installation.

## Important Notes

- The build process uses Nix's native SD image generation capabilities
- Make sure to backup any important data before flashing the image
- The first boot may take longer as the system initializes 