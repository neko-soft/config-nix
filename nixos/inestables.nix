{ config, pkgs, ... }:

let
  unstable = import <unstable> { };
in
{
  environment.systemPackages = with unstable.pkgs; [
    qbittorrent
    wineWowPackages.stagingFull
    winetricks
    krita
    #opentabletdriver
    bottles
    #davinci-resolve
  ];
}
