#!/bin/bash
DOCKER_IMAGE_NAME="ptrsr/my-nix"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)/../"

DIST_DIR="$PROJECT_DIR/dist"
SRC_DIR="$PROJECT_DIR/src"

# Create necessary directory
mkdir -p "$DIST_DIR"

# Run the container with all necessary mounts
docker run -it \
    -v $DIST_DIR:/dist \
    -v $SRC_DIR:/src \
    -w /build \
    --entrypoint bash \
    $DOCKER_IMAGE_NAME "$@"
