{ config, pkgs, ... }:

let
  unstable = import <unstable> { };
in
{
  environment.systemPackages = with unstable.pkgs; [
    qbittorrent
    wineWowPackages.waylandFull
    #winetricks
    krita
    #opentabletdriver
    bottles
  ];
}
