{ config, pkgs, ... }:

{
  imports = [
    ./hardware/configuration.nix
    # ./network/configuration.nix
    # ./services/configuration.nix
    # ./drive/configuration.nix
  ];

  # Enable NixOS features
  nixpkgs.overlays = [
    (final: prev: {
      # Add any custom package overlays here
    })
  ];

  # System configuration
  system.stateVersion = "23.11"; # Adjust this to match your NixOS version

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # System utilities
    vim
    wget
    curl
    git
    htop
    tmux
    whois
  ];

  time.timeZone = "Europe/Amsterdam";

  users.users = {
    test = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "admin" ];
      hashedPassword = null;
      home = "/home/test";
    };
  };

  users.groups = {
    admin = {
      gid = 2000;
    };
  };

  # SSH configuration
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };

  # Hostname configuration
  networking.hostName = "my-pi"; # Replace with your desired hostname

  # Create configuration directory with proper permissions
  system.activationScripts.configSetup = ''
    mkdir -p /etc/nixos
    chown root:admin /etc/nixos
    chmod 750 /etc/nixos
  '';

  # Boot configuration
  boot = {
    # Use the latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
