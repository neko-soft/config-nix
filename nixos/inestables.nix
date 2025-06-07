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
    wineWowPackages.unstableFull
    winetricks
    krita
    #opentabletdriver
    bottles
    nomacs
    #lutris
    #davinci-resolve
  ];
}
