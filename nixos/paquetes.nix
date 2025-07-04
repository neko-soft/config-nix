# Este módulo de Nix tiene todos los paquetes que tenemos


{ lib, config, pkgs, ... }:


{ 

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		

		# Aplicaciones básicas
		#firefox
		spotify	thunderbird obsidian kitty vscode 
		xfce.thunar
		xfce.tumbler
		xfce.thunar-volman
		neovim
		iotop
		lsof
		#wofi
		vlc
		p7zip discord playerctl pywal
		#google-chrome
		librewolf
		bibata-cursors
		exfat
		efibootmgr
		gnome-calculator
		spotify-player
		#bluez
		gallery-dl
		parabolic
		mission-center
		cameractrls
		easyeffects
		pavucontrol
		wl-clipboard
		moonlight-qt
		catppuccin-grub
		#catppuccin-sddm
  		#catppuccin-sddm.override {
    		#	flavor = "mocha";
    		#	font  = "Noto Sans";
    		#	fontSize = "9";
    		#	background = "${./wallpaper.png}";
    		#	loginBackground = true;
  		#}
		# Análisis
		htop killall vnstat iftop

		# Programas Creativos		
		#reaper davinci-resolve 
		#krita
		#davinci-resolve

		# Terminal y Kitty
		fastfetch asciiquarium cmatrix lf neo-cowsay fortune-kind pipes
		nsnake cava sl cbonsai tty-clock cool-retro-term hollywood
		glava
		# Extras
		mpvpaper ffmpeg mpv swww jq
		
		# Hyprland y Desktop Environment
		waybar rofi-wayland hyprpaper dunst libnotify
		#wlogout
		swaylock-effects wl-clipboard grim slurp hyprpolkitagent
		wtype

		# Control de Hardware
		lm_sensors pulseaudioFull brightnessctl	lshw
		#openrgb-with-all-plugins

		#lutris bottles ventoy-full

		# Máquinas Virtuales
		#virt-viewer spice spice-gtk spice-protocol win-virtio win-spice swtpm
		virtiofsd
		virtio-win
		
		# Develop y Compilar
		#cmake gnumake libgcc clang openssl boost
	
		# Home-Manager
		#home-manager

		# Imágenes
		imagemagick

		# Office
		libreoffice-still

		# Extras		
		#polkit polkit_gnome
		kdePackages.kirigami gvfs simple-mtpfs usbutils
		unzip nerd-fonts.hack ntfs3g os-prober #adwaita-icon-theme
		git #openvpn
		#openrgb-with-all-plugins
		#opentabletdriver

		rocmPackages.clr
		rocmPackages.rocminfo

		nerd-fonts.jetbrains-mono
		nerd-fonts.hack

 	 ];

	#hardware.bluetooth.enable = true;
	#services.blueman.enable = true;
	hardware.amdgpu.opencl.enable = true;
	programs.steam.enable = true;
	programs.obs-studio.enable = true;
	#programs.firefox.enable = true;

	services.udisks2.enable = true;
	services.dbus.enable = true;
	services.gvfs.enable = true;


	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 7d";
	};

	# Power managment
	services.power-profiles-daemon.enable = false;
	services.thermald.enable = false;
	powerManagement.enable = true;
	services.tlp = {
		enable = true;
		settings = {
			CPU_SCALING_GOVERNOR_ON_AC = "performance";
			CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

			CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
			CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

			CPU_MIN_PERF_ON_AC = 0;
			CPU_MAX_PERF_ON_AC = 100;
			CPU_MIN_PERF_ON_BAT = 0;
			CPU_MAX_PERF_ON_BAT = 50;

			START_CHARGE_THRESH_BAT0 = 40;
			STOP_CHARGE_THRESH_BAT0 = 80;
		};
	};

	# Polkit y authentication
	security.polkit.enable = true;

	# RGB
	services.hardware.openrgb.enable = false;
	hardware.opentabletdriver = {
		enable = true;
		daemon.enable = true;
	};


	# Virtualización y KVM
	virtualisation = {
		libvirtd = {
			enable = true;
			onShutdown = "shutdown";
			qemu = {
				swtpm.enable = true;
				ovmf.enable = true;
				ovmf.packages = [ pkgs.OVMFFull.fd ];
			};
		};
		spiceUSBRedirection.enable = true;
	};
	services.spice-vdagentd.enable = true;
	programs.virt-manager.enable = true;

	# Para MySQL

	services.mysql = {
		enable = false;
		package = pkgs.mariadb;
	};


	# Para SSH en GitHub

	programs.ssh = {
		startAgent = true;
		extraConfig = ''
			Host github.com
			AddKeysToAgent yes
			IdentityFile ~/.ssh/id_ed25519
			IdentityFile ~/.ssh/id_ed25519_signing
		'';
	};


	# Fuentes para las letras y caracteres
	fonts.packages = with pkgs ; [
		font-awesome
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-emoji
		liberation_ttf
		fira-code
		fira-code-symbols
		mplus-outline-fonts.githubRelease
		dina-font
		proggyfonts
	];

 	# Allow unfree packages
 	nixpkgs.config.allowUnfree = true;



nix.settings = {
	substituters = [
   		"https://nix-community.cachix.org"
		"https://cuda-maintainers.cachix.org"
  	];
	trusted-public-keys = [
    		"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
   	 	"cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
  	];
};


}


