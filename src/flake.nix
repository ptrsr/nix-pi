{
  description = "Unified flake for x86 and Raspberry Pi builds";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi";
  };

  outputs = inputs@{ self, nixpkgs, nixos-raspberrypi, ... }: let
    inherit (builtins) getEnv;
    # target = let t = getEnv "TARGET"; in if t == "" then "x86" else t;
    target = "pi";

    machineSystem = if target == "x86" then
      nixpkgs.lib.nixosSystem {
        system  = "x86_64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-x86_64.nix"
          ./common/configuration.nix
        ];
      }
    else
      nixos-raspberrypi.lib.nixosSystem {
        specialArgs = inputs;
        modules = [
          { imports = with nixos-raspberrypi.nixosModules; [
              raspberry-pi-5.base
              sd-image
            ];
          }
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              raspberrypi-utils
              libraspberrypi
              raspberrypifw
              raspberrypiWirelessFirmware
            ];
          })
          ./common/configuration.nix
        ];
      };
  in {
    nixosConfigurations.machine = machineSystem;
    image = self.nixosConfigurations.machine.config.system.build.sdImage;
  };
}
