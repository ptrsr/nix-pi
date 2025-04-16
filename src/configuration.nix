{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ffmpeg_6
    sudo
  ];

  users = {
    users = {
      nixos = {
        isNormalUser = true;
        extraGroups = [ "wheel" "docker" "admin" ];
        password = "nixos";
        home = "/home/test";
      };
    };
    groups = {
      admin = {
        gid = 2000;
      };
    };
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
}
