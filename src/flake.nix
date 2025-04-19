{
  description = "Unified flake for x86 and Raspberry Pi builds";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi";
  };

  outputs = inputs@{ self, nixos-raspberrypi, ... }: {

    nixosConfigurations.machine = nixos-raspberrypi.lib.nixosSystem {
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
    packages.aarch64-linux.default =
      self.nixosConfigurations.machine.config.system.build.sdImage;

    image = self.nixosConfigurations.machine.config.system.build.sdImage;


  # outputs = inputs@{ self, nixpkgs, nixos-raspberrypi, ... }:
  #   let
  #     inherit (builtins) getEnv;
  #     target = getEnv "TARGET";
  #     selectedTarget = if target == "" then "x86" else target;

  #     # x86System = nixpkgs.lib.nixosSystem {
  #     #   system = "x86_64-linux";
  #     #   modules = [
  #     #     "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-x86_64.nix"
  #     #     ./common/configuration.nix
  #     #   ];
  #     # };

  #     rpiSystem = nixos-raspberrypi.lib.nixosSystem {
  #       system = "aarch64-linux";
  #       specialArgs = inputs;
  #       modules = [
  #         { imports = with nixos-raspberrypi.nixosModules; [ raspberry-pi-5.base sd-image ]; }
  #         ({ pkgs, ... }: {
  #           environment.systemPackages = with pkgs; [
  #             raspberrypi-utils libraspberrypi raspberrypifw raspberrypiWirelessFirmware
  #           ];
  #         })
  #         ./common/configuration.nix
  #       ];
  #     };
  #   in
  #   {
  #     image = rpiSystem.config.system.build.sdImage;
  #     # image =
  #     #   if selectedTarget == "x86" then
  #     #     x86System.config.system.build.sdImage
  #     #   else
  #     #     rpiSystem.config.system.build.sdImage;
  };
}
