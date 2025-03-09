# Este módulo de Nix tiene todos los paquetes que tenemos


{ lib, config, pkgs, ... }:


{ 



	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		# Aplicaciones básicas
		firefox
		spotify
		thunderbird
		obsidian
		kitty
		vscodium
		xfce.thunar
		neovim
		#qbittorrent

		# Programas Creativos		
		#reaper
		#davinci-resolve
		#krita
		#davinci-resolve-studio

		# Terminal y Kitty
		fastfetch
		asciiquarium
		cmatrix
		lf
		neo-cowsay
		fortune-kind
		pipes
		nsnake
		cava
		sl
		cbonsai
		
		# Hyprland y Desktop Environment
		waybar
		rofi-wayland
		hyprpaper
		dunst
		libnotify
		#wlogout
		swaylock-effects
		wl-clipboard
		grim
		slurp

		# Control de Hardware y weás
		lm_sensors
		pulseaudioFull
		brightnessctl
		lshw
		openrgb-with-all-plugins

		#lutris
		bottles
		ventoy-full

		# Máquinas Virtuales
		virt-viewer
		spice
		spice-gtk
		spice-protocol
		win-virtio
		win-spice
		swtpm
		
		# Develop y Compilar
		#cmake
		#gnumake
		#libgcc
		#clang
		#openssl
		#boost
	
		# Home-Manager
		home-manager

		# Extras		
		#polkit
		#polkit_gnome
		kdePackages.kirigami
		gvfs		
		unzip
		nerdfonts		
		ntfs3g
		os-prober
		adwaita-icon-theme
		git


 	 ];
	#Home Manager
	#programs.home-manager.enable = true;

	# Power managment y weás
	services.thermald.enable = true;
	powerManagement.enable = true;

	# Polkit y authentication cosas
	security.polkit.enable = true;

	# RGB
	services.hardware.openrgb.enable = false;
	hardware.opentabletdriver.enable = true;
	# Weás de GPU

	#hardware.opengl = {
	#enable = true;
	#driSupport = true;
	#driSupport32Bit = true;
	#extraPackages = with pkgs; [
	#	rocmPackages.clr.icd
	#	];
	#};


	# Virtualización y cosas de KVM
	virtualisation = {
		libvirtd = {
			enable = true;
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
		enable = true;
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

	# Permite algunos paquetes inseguros que son necesarios para algunas cosas
	nixpkgs.config.permittedInsecurePackages = [
		"electron-25.0.0"
		"qbittorrent-4.6.4"
		"dotnet-runtime-6.0.36"
		"dotnet-sdk-wrapped-6.0.428"
		"dotnet-sdk-6.0.428"
	];

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


}


