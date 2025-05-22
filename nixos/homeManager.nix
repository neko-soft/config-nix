{ config, pkgs, lib, ... }:

{
  #programs.home-manager.enable = true;

  users.users.nekonix = {
    isNormalUser = true;
    home = "/home/nekonix";
  };

  #imports = [
  #  ./dotFiles/swaylock.nix
  #];

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
  ./dotFiles/glava.nix
  ./dotFiles/rofi.nix
      ];
      home.packages = with pkgs; [ font-awesome noto-fonts noto-fonts-emoji
      hack-font fira-code fira-code-symbols];
      fonts.fontconfig.enable = true;
      home.stateVersion = "24.11"; # Ajusta según la versión de NixOS


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
