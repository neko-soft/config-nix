# Este módulo tiene todo sobre el bootloader
{ lib, config, pkgs, ... }:


{ 

# Bootloader. Está activado el Grub
boot.loader = {
	systemd-boot.enable = false;
	efi.canTouchEfiVariables = true;
	grub = {
		enable = true;
		devices = [ "nodev" ];
		efiSupport = true;
		useOSProber = true;
		default = 0;
		theme = "${pkgs.catppuccin-grub}";
		#splashImage = /home/nekonix/wallpapers/Kath.png;
		efiInstallAsRemovable = false;
	};
};
}
