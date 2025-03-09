{ config, pkgs, ... }:

{
  #programs.home-manager.enable = true;

  users.users.nekonix = {
    isNormalUser = true;
    home = "/home/nekonix";
  };

  home-manager.users.nekonix = { pkgs, ... }: {
    home.stateVersion = "24.11"; # Ajusta según la versión de NixOS
    #programs.zsh.enable = true;
    #programs.git.enable = true;
  };
}
