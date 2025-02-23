# Este módulo tiene todo sobre el network y el host y usuario y cosas
{ lib, config, pkgs, ... }:


{ 

	networking.hostName = "nixos"; # Define your hostname.
	#networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;


	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.nekonix = {
		isNormalUser = true;
		description = "NekoNix";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
	};





}
