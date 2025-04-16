{
  inputs.nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi";
  inputs.nixpkgs.follows = "nixos-raspberrypi/nixpkgs";

  outputs = { self, nixpkgs, nixos-raspberrypi }: {
    nixosConfigurations.rpi5 = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        nixos-raspberrypi.nixosModules.raspberry-pi-5.base
        nixos-raspberrypi.nixosModules.sd-image
        nixos-raspberrypi.nixosModules.nixpkgs-rpi
        nixos-raspberrypi.lib.inject-overlays
        nixos-raspberrypi.nixosModules.trusted-nix-caches # optional, recommended
        ./configuration.nix
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            raspberrypi-utils
            libraspberrypi
            raspberrypifw
            raspberrypiWirelessFirmware
          ];
        })
      ];
    };

    packages.aarch64-linux.default =
      self.nixosConfigurations.rpi5.config.system.build.sdImage;
  };
}
