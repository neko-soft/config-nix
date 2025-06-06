#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Copiar .bashrc 
sudo cp "$REPO_ROOT/.bashrc" "$HOME/"

# Copiar los archivos de Glava
sudo cp -r "$REPO_ROOT/glava/" "$HOME/.config/"

# Agregar canales

year_full=$(date +%Y)
year_short=$(date +%y)
month=$(date +%m)

if (( month < 6 )); then
  stable_nixos="nixos-$((year_short - 1)).11"
  stable_hm="release-$((year_short - 1)).11"
elif (( month < 12 )); then
  stable_nixos="nixos-$year_short.05"
  stable_hm="release-$year_short.05"
else
  stable_nixos="nixos-$year_short.11"
  stable_hm="release-$year_short.11"
fi

echo "Canal estable calculado para NixOS: $stable_nixos"
echo "Canal estable calculado para home-manager: $stable_hm"
echo
echo "Elige canal para NixOS:"
echo "1) Estable ($stable_nixos)"
echo "2) Inestable (nixos-unstable + home-manager master)"
echo "3) Salir sin cambios"
read -rp "Opción: " opcion

case $opcion in
  1)
    nix_channel_nixos=$stable_nixos
    nix_channel_hm=$stable_hm
    ;;
  2)
    nix_channel_nixos="nixos-unstable"
    nix_channel_hm="master"
    ;;
  *)
    echo "Saliendo sin cambios."
    exit 0
    ;;
esac

echo "Configurando canales..."

sudo nix-channel --add "https://nixos.org/channels/$nix_channel_nixos" nixos
sudo nix-channel --add "https://nixos.org/channels/nixos-unstable" unstable

if [ "$nix_channel_hm" = "master" ]; then
  sudo nix-channel --add "https://github.com/nix-community/home-manager/archive/master.tar.gz" home-manager
else
  sudo nix-channel --add "https://github.com/nix-community/home-manager/archive/$nix_channel_hm.tar.gz" home-manager
fi

sudo nix-channel --update


echo "Canales actualizados."

# Preguntar si hay GPU Nvidia

read -rp "¿GPU Nvidia? (y/N): " respuesta
if [[ "$respuesta" =~ ^[Yy]$ ]]; then
  # Descomenta la línea (quita # si existe)
  sudo sed -i 's|^\(\s*\)#\?\(\./nvidia.nix\)|\1\2|' "$REPO_ROOT/nixos/configuration.nix"
else
  # Comenta la línea (pone # si no está)
  sudo sed -i 's|^\(\s*\)\(#\?\)\(\./nvidia.nix\)|\1#\3|' "$REPO_ROOT/nixos/configuration.nix"
fi



# Respaldo de archivos .nix originales

mkdir -p  "$REPO_ROOT/nixos/respaldo"

sudo cp /etc/nixos/configuration.nix "$REPO_ROOT/nixos/respaldo/"
sudo cp /etc/nixos/hardware-configuration.nix "$REPO_ROOT/nixos/respaldo/"


# Cambio de linea de boot.initrd.luks.devices y stateVersion
# Esto es importante porque sino, no funciona nada

# Guardamos la línea que contiene 'boot.initrd.luks.devices.' del respaldo
luks_line=$(grep 'boot.initrd.luks.devices.' "$REPO_ROOT/nixos/respaldo/configuration.nix")
versionLine=$(grep "stateVersion" "$REPO_ROOT/nixos/respaldo/configuration.nix" | sed 's/system\.//')



# Reemplazamos esa línea en el archivo principal
sed -i "s|.*boot.initrd.luks.devices.*|$luks_line|" "$REPO_ROOT/nixos/configuration.nix"
sed -i "s|^\(.*stateVersion\s*=.*\)|  $versionLine|" "$REPO_ROOT/nixos/configuration.nix"



# Descomentar homeManager para evitar problemas durante el primer rebuild


sudo sed -i '/<home-manager\/nixos>/ s/^[^#]/#&/' "$REPO_ROOT/nixos/configuration.nix"
sudo sed -i '/\.\/homeManager.nix/ s/^[^#]/#&/' "$REPO_ROOT/nixos/configuration.nix"



# Copiar archivos del repo al sistema y primer rebuild

sudo cp  -r $REPO_ROOT/nixos/ /etc/
sudo nixos-rebuild switch

# Descomentar homeManager y segundo rebuild

sudo sed -i '/<home-manager\/nixos>/ s/^#\(.*\)/\1/' /etc/nixos/configuration.nix
sudo sed -i '/\.\/homeManager.nix/ s/^#\(.*\)/\1/' /etc/nixos/configuration.nix

sudo nixos-rebuild switch
