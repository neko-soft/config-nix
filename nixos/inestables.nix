{ config, pkgs, ... }:

let
  unstable = import <unstable> { };
in
{
  environment.systemPackages = with unstable.pkgs; [
    qbittorrent
    krita
    bottles
  ];
}
