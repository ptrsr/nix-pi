FROM nixos/nix:2.28.1

# Create build directory
WORKDIR /build

# Enable Nix experimental features
ENV NIX_CONFIG='experimental-features = nix-command flakes'

# Set the entry point
ENTRYPOINT ["/src/entrypoint.sh"]
