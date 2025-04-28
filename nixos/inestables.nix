{ config, pkgs, ... }:

let
  unstable = import <unstable> { };
in
{
  environment.systemPackages = with unstable.pkgs; [
    qbittorrent
	wineWow64Packages.stagingFull  
	#wineWow64Packages.waylandFull
	
   
    #winetricksi
    krita
    #opentabletdriver
    #bottles
  ];
}
