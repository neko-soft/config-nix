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

# Verificación de canal actual:

current_nixos_channel=$(sudo nix-channel --list | grep "^nixos" | awk '{print $2}' | sed 's|.*/||')
currentVersion=$(echo "$current_nixos_channel" | sed 's/^nixos-//')






echo "Canal estable recomendado para NixOS y Home Manager: $currentVersion"
echo "El canal actual de NixOS es '$current_nixos_channel'."

#echo "Canal estable calculado para home-manager: $stable_hm"
echo " "


echo "Seleccione el canal a utilizar para NixOS y Home Manager"

echo "1) Estable ($stable_nixos + $stable_hm)"
echo "2) Inestable (nixos-unstable + home-manager master)"
echo "3) Mantener canal actual ($current_nixos_channel + home-manager $currentVersion)."
echo "9) Salir sin cambios"
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
  3)
    nix_channel_nixos=$current_nixos_channel
    if [[ "$currentVersion" == "unstable" ]]; then
      nix_channel_hm="master"
    else
      nix_channel_hm="release-$currentVersion"
    fi
    ;;
  *)
    echo "Saliendo sin cambios."
    exit 0
    ;;
esac

echo "Configurando canales..."

sudo nix-channel --add "https://nixos.org/channels/$nix_channel_nixos" nixos
echo "Canal '$nix_channel_nixos' agregado como 'nixos'."

# VERIFICA SI EL HOME MANAGER EXISTE SIQUIERA.....


sudo sed -i "s#https://github.com/nix-community/home-manager/archive/.*\.tar\.gz#https://github.com/nix-community/home-manager/archive/${nix_channel_hm}.tar.gz#" "$REPO_ROOT/nixos/homeManager.nix"
echo "Home Manager versión '$nix_channel_hm' agregado declarativamente en '/etc/nixos/homeManager.nix'."

#if [ "$nix_channel_hm" = "master" ]; then
#  sudo nix-channel --add "https://github.com/nix-community/home-manager/archive/master.tar.gz" home-manager
#else
#  sudo nix-channel --add "https://github.com/nix-community/home-manager/archive/$nix_channel_hm.tar.gz" home-manager
#fi

echo "Actualizando canales."
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





# Todo esto para abajo ya no se usa.

# Descomentar homeManager para evitar problemas durante el primer rebuild


#sudo sed -i '/<home-manager\/nixos>/ s/^[^#]/#&/' "$REPO_ROOT/nixos/configuration.nix"
#sudo sed -i '/\.\/homeManager.nix/ s/^[^#]/#&/' "$REPO_ROOT/nixos/configuration.nix"



# Copiar archivos del repo al sistema y reconstruir

sudo cp  -r $REPO_ROOT/nixos/ /etc/
sudo nixos-rebuild switch

# Descomentar homeManager y segundo rebuild

#sudo sed -i '/<home-manager\/nixos>/ s/^#\(.*\)/\1/' /etc/nixos/configuration.nix
#sudo sed -i '/\.\/homeManager.nix/ s/^#\(.*\)/\1/' /etc/nixos/configuration.nix

#sudo nixos-rebuild switch
