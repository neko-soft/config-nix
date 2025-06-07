{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
in


{
  #programs.home-manager.enable = true;

  users.users.nekonix = {
    isNormalUser = true;
    home = "/home/nekonix";
  };

  imports =
    [
      (import "${home-manager}/nixos")
    ];


  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nekonix = { pkgs, ... }: {
      imports = [
        ./dotFiles/swaylock.nix
        ./dotFiles/cava.nix
        ./dotFiles/dunst.nix
        ./dotFiles/waybar.nix
        ./dotFiles/hyprland.nix
        ./dotFiles/kitty.nix
        ./dotFiles/rofi.nix

        #./dotFiles/glava/bars.nix
        #./dotFiles/glava/circle.nix
        #./dotFiles/glava/envs.nix
        #./dotFiles/glava/glava.nix
        #./dotFiles/glava/graph.nix
        #./dotFiles/glava/radial.nix
        #./dotFiles/glava/util.nix
        #./dotFiles/glava/wave.nix
      ];
      home.packages = with pkgs; [ font-awesome noto-fonts noto-fonts-emoji
      nerd-fonts.hack fira-code fira-code-symbols];
      home.pointerCursor = {
   		gtk.enable = true;
    		# x11.enable = true;
    		package = pkgs.bibata-cursors;
    		name = "Bibata-Modern-Ice";
    		size = 24;
  	};

      gtk = {
    	enable = true;

    	theme = {
     		package = pkgs.flat-remix-gtk;
      		name = "Flat-Remix-GTK-Grey-Darkest";
    	};

     	iconTheme = {
     		package = pkgs.adwaita-icon-theme;
      		name = "Adwaita";
    	};

     	font = {
		name = "Noto Sans";
		size = 10;
     	};
     };
      fonts.fontconfig.enable = true;
      home.stateVersion = "25.05"; # Ajusta según la versión de NixOS


        wayland.windowManager.hyprland.systemd.variables = ["--all"];


        programs.git = {
          enable = true;
          userName = "neko-soft";    # Cambia esto por tu nombre
          userEmail = "rodrigo.pereira.riquelme@gmail.com";  # Cambia esto por tu correo de GitHub

          # Configuración avanzada
          extraConfig = {
            init.defaultBranch = "main";  # Usa 'main' en lugar de 'master'
            pull.rebase = true;           # Hace 'pull' con rebase en vez de merge
            core.editor = "nvim";          # Usa nano como editor por defecto
            credential.helper = "store";   # Guarda credenciales en ~/.git-credentials
            http.postBuffer = 524288000;   # Aumenta el tamaño del buffer (500MB)
            gpg.format = "ssh";
	  };

	  signing = {
	  	key = "/home/nekonix/.ssh/id_ed25519_signing";
		signByDefault = true;
	};

          # Si quieres usar SSH con GitHub, puedes agregar tus claves
          #signing.signByDefault = false;
        };

    };

      
  };
  
}
