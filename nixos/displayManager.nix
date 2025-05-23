# Aquí vamos a poner todo lo relacionado a los diplay managers,
# ya sea Hyprland, Xserver, Gnome o lo que sea

{ lib, config, pkgs, ... }:


{ 
	# Esto habilita GNOME y KDE Plasma.
	services = {
  		xserver = {
			enable = true;
			displayManager.gdm.enable = false;
			desktopManager.gnome.enable = false;
  			xkb.layout = "latam";
			xkb.variant = "";
		};
		displayManager = {
			sddm.enable = true;
		};
		desktopManager.plasma6.enable = true;
		};

	# Esto habilita Hyprland.
	# Tener en cuenta que hay que agregar varias cosas si usas NVIDIA
	programs.hyprland.enable = true;
	hardware.graphics = {
		enable = true;
		package = pkgs.mesa;
		extraPackages = [pkgs.rocmPackages.clr];
	};
	
	# Impresora
	services.printing.enable = false;

	qt.enable = true;
	

	# XDG Portal
	xdg.portal.enable = true;
	xdg.portal.extraPortals = [
		pkgs.xdg-desktop-portal-gtk
		pkgs.xdg-desktop-portal-hyprland
		pkgs.kdePackages.xdg-desktop-portal-kde
		];


	# Audio
	services.pulseaudio.enable = false;
	#sound.enable = true;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = false;
	};




}
