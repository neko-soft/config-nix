
{ lib, config, pkgs, ... }:


{ 

# Añade las dependencias necesarias
environment.systemPackages = with pkgs; [
    cmake
    clang
    boost
    openssl
    zlib
    readline
    bzip2
    mysql84
    mariadb_114
    screen
];

# Configurar el servicio de ac-authserver
systemd.services.ac-authserver = {
  description = "AzerothCore Authserver";
  after = [ "network.target" ];

  serviceConfig = {
    Type = "simple";
    Restart = "always";
    RestartSec = "1";
    User = "nekonix";  # Asegúrate de que este sea el nombre de usuario correcto
    WorkingDirectory = "/home/nekonix/azerothcore";  # Ruta correcta al directorio de AzerothCore
    ExecStart = "./acore.sh run-authserver";  # Ajusta el comando si es necesario
  };

  wantedBy = [ "multi-user.target" ];
};

# Hacer lo mismo para ac-worldserver
systemd.services.ac-worldserver = {
  description = "AzerothCore Worldserver";
  after = [ "network.target" ];

  serviceConfig = {
    Type = "simple";
    Restart = "always";
    RestartSec = "1";
    User = "nekonix";  # Asegúrate de que este sea el nombre de usuario correcto
    WorkingDirectory = "/home/nekonix/azerothcore";  # Ruta correcta al directorio de AzerothCore
    ExecStart = "/run/current-system/sw/bin/screen -S worldserver -D -m ./acore.sh run-worldserver";  # Ajusta el comando si es necesario
  };

  wantedBy = [ "multi-user.target" ];
};


  
systemd.user.services.hyprland-reload = {
  description = "Reload Hyprland after nixos-rebuild switch";
  after = [ "graphical-session.target" ];
  wantedBy = [ "default.target" ];
  serviceConfig = {
    Environment = "HYPRLAND_INSTANCE_SIGNATURE=12f9a0d0b93f691d4d9923716557154d74777b0a_1741629681_1843579763";
    ExecStart = "/run/current-system/sw/bin/bash -c '/run/current-system/sw/bin/hyprpaper'";
    Type = "simple";
    Restart = "on-failure";
    RestartSec = 5;
  };
};



}
