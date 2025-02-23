{ config, pkgs, ... }:

let
  unstable = import <unstable> { };
in
{
  environment.systemPackages = with unstable.pkgs; [
    # Your stable packages here...
    qbittorrent  # Replace with the actual unstable package name
    krita
    bottles
  ];
}
