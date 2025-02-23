# Este módulo tiene todo sobre el bootloader
{ lib, config, pkgs, ... }:


{ 

	# Bootloader. Está activado el Grub, además del OS prober por si hay Windows instalado
	boot.loader = {
	#systemd-boot.enable = true;
	efi.canTouchEfiVariables = true;
	grub = {
		enable = true;
		devices = [ "nodev" ];
		efiSupport = true;
		useOSProber = true;
		default = 0;
		splashImage = /home/nekonix/Kath.png;
		};
	};
}
