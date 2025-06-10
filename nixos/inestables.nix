{ config, pkgs, ... }:

let
  inherit (pkgs) system config overlays;

  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  }) {
    inherit system config overlays;
  };
in
{
  environment.systemPackages = with unstable.pkgs; [
    qbittorrent
    #wineWowPackages.stagingFull
    #winetricks
    krita
    #opentabletdriver
    #bottles
    nomacs
    #kdePackages.kdenlive
    #ladspaPlugins
    #audacity
    #lutris
    #davinci-resolve
  ];
}
