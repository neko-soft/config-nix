# Este módulo tiene todo sobre el bootloader
{ lib, config, pkgs, ... }:


{ 

# Bootloader. Está activado el Grub
boot.loader = {
	#systemd-boot.enable = true;
	efi.canTouchEfiVariables = true;
	grub = {
		enable = true;
		devices = [ "nodev" ];
		efiSupport = true;
		useOSProber = false;
		default = 0;
		splashImage = /home/nekonix/wallpapers/Kath.png;
		extraConfig = ''
			GRUB_DISABLE_SUBMENU=y
		'';
	};
};
}
