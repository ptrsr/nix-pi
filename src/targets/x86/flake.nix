{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.x86 = nixpkgs.lib.nixosSystem {
      system  = "x86_64-linux";
      modules = [
        "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-x86_64.nix"
        ./common/configuration.nix
      ];
    };
    image = self.nixosConfigurations.x86.config.system.build.sdImage;
  };
}
