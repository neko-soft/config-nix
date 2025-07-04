# Aquí vamos a poner todo lo relacionado a los diplay managers,
# ya sea Hyprland, Xserver, Gnome o lo que sea

{ lib, config, pkgs, ... }:


{

	environment.systemPackages = [(
  		pkgs.catppuccin-sddm.override {
    		flavor = "mocha";
    		font  = "Noto Sans";
    		fontSize = "9";
    		background = "${/home/nekonix/wallpapers/Kath.png}";
    		loginBackground = true;
  		}
	)];

	# Esto habilita GNOME y KDE Plasma.
	services = {
  		xserver = {
			enable = true;
			displayManager.lightdm.enable = false;
			displayManager.gdm.enable = false;
			desktopManager.gnome.enable = false;
  			xkb.layout = "latam";
			xkb.variant = "";
		};
		displayManager = {
			sddm.enable = false;
			#sddm.theme = "catppuccin-mocha";
			#sddm.package = pkgs.kdePackages.sddm;
		};
		desktopManager.plasma6.enable = false;
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


	# Ventiladores
	boot.kernelModules = [ "ec_sys" ];
  	boot.extraModprobeConfig = ''
    		options ec_sys write_support=1
  	'';
	boot.supportedFilesystems = ["debugfs"];
	fileSystems."/sys/kernel/debug" = {
		fsType = "debugfs";
		device = "debugfs";
	};


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
