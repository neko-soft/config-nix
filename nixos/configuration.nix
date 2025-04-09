# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports = [
		# Include the results of the hardware scan.
		./hardware-configuration.nix
		./paquetes.nix
		./displayManager.nix
		./bootLoader.nix
		./localeAndTime.nix
		./networkAndHost.nix
		#./nvidia.nix
		./inestables.nix
    #./servicios.nix
		<home-manager/nixos>
		./cachix.nix
		./homeManager.nix
		#./nas.nix
    ];


  boot.initrd.luks.devices."luks-a1ebf852-7aee-47ef-b5c7-54392bb7485b".device = "/dev/disk/by-uuid/a1ebf852-7aee-47ef-b5c7-54392bb7485b";

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system = {
  	stateVersion = "24.05";
	autoUpgrade = {
		enable = false;
		allowReboot = false;
	};
  };
}
