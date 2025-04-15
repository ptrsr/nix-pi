#!/bin/bash

DOCKER_IMAGE_NAME="ptrsr/my-nix"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)/../"

# Build Docker image
docker build -t $DOCKER_IMAGE_NAME $PROJECT_DIR
