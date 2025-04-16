{
  description = "x86-64 SD image";

  inputs.nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi";

  outputs = inputs@{ self, nixos-raspberrypi, ... }: {
    nixosConfigurations.rpi5 = nixos-raspberrypi.lib.nixosSystem {
      specialArgs = inputs;
      modules = [
        ({ imports = with nixos-raspberrypi.nixosModules; [
            raspberry-pi-5.base
            sd-image
          ]; })
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            raspberrypi-utils
            libraspberrypi
            raspberrypifw
            raspberrypiWirelessFirmware
          ];
        })
        ../../configuration.nix
      ];
    };

    image = self.nixosConfigurations.rpi5.config.system.build.sdImage;
  };
}
