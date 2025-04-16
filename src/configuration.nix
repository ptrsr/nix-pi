{ config, pkgs, ... }:

{
  users = {
    users.nixos = {
      isNormalUser    = true;
      extraGroups     = [ "wheel" "docker" "admin" ];
      home            = "/home/nixos";
      initialPassword = "nixos";
    };

    groups.admin.gid = 2000;
  };

  security.sudo = {
    enable             = true;
    wheelNeedsPassword = false;
  };

  environment.systemPackages = with pkgs; [
    ffmpeg_6
    sudo
  ];

  networking.hostName = "my-nix";
  time.timeZone       = "Europe/Amsterdam";
  services.openssh.enable = true;
}
