#!/usr/bin/env bash

# Este script es para cambiar fondos de pantalla automáticamente. La idea es que hay una carpeta en $HOME/walpapapers con todos los archivos de imágenes para usar. Ahí, el script pregunta cuál imagen quieres de fondo de pantalla, y actualiza el archivo homeManager.nix con el nuevo path de imagen. También debe preguntar si quieres cambiar el fondo de GRUB con la misma imagen.


# Paths
WALLPAPER_DIR="$HOME/wallpapers"
HOMEMANAGER_DIR="/etc/nixos/homeManager.nix"
GRUB_DIR="/etc/nixos/bootLoader.nix"
script_dir=$(dirname "$0")

# Verificar si existe la carpeta de wallpapers o no.

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: La carpeta $WALLPAPER_DIR no existe."
    exit 1
fi

# Obtener la lista de imágenes (JPG y PNG)
IMAGES=($(ls "$WALLPAPER_DIR" | grep -E "\.(jpg|jpeg|png)$"))

# Verificar si hay imágenes en la carpeta
if [ ${#IMAGES[@]} -eq 0 ]; then
    echo "No hay imágenes en la carpeta $WALLPAPER_DIR."
    exit 1
fi

# Mostrar la lista de imágenes numeradas
echo "Selecciona una imagen para el fondo de pantalla:"
echo ""
for i in "${!IMAGES[@]}"; do
    echo "[$i] ${IMAGES[$i]}"
done

# Pedir al usuario que elija un número
echo ""
read -p "Número de la imagen: " choice

# Verificar si la elección es válida
if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 0 ] || [ "$choice" -ge "${#IMAGES[@]}" ]; then
    echo "Selección inválida."
    exit 1
fi

# Obtener el nombre del archivo seleccionado
SELECTED_IMAGE="${IMAGES[$choice]}"
SELECTED_PATH="$WALLPAPER_DIR/$SELECTED_IMAGE"

echo $SELECTED_PATH

# Modificar la configuración en homeManager.nix
echo "Modificando configuración de homeManager.nix..."
echo ""
sudo sed -i "s|preload = .*|preload = $SELECTED_PATH|" "$HOMEMANAGER_DIR"
sudo sed -i "s|wallpaper = .*|wallpaper = ,$SELECTED_PATH|" "$HOMEMANAGER_DIR"

wal -nqse -i $SELECTED_PATH
bash "$script_dir/cambiarTema.sh"

# Preguntar por el fondo de pantalla de GRUB
echo "¿Desea cambiar el fondo de pantalla de GRUB con la misma imagen?"
echo ""
echo "1) Sí"
echo "2) No, mantener la anterior"
echo "3) No, elegir otra imagen"
read -p "Seleccione una opción (1-3): " GRUB_SELECTION


if [[ "$GRUB_SELECTION" == "1" ]]; then


    # Convertir a PNG si no es PNG
    EXT="${SELECTED_IMAGE##*.}"
    FILENAME="${SELECTED_IMAGE%.*}"
    PNG_PATH="$WALLPAPER_DIR/$FILENAME.png"

    if [ "$EXT" != "png" ]; then
        echo "Convirtiendo $SELECTED_IMAGE a PNG..."
        magick "$SELECTED_PATH" "$PNG_PATH"
        SELECTED_PATH="$PNG_PATH"
    fi

    sudo sed -i "s|splashImage = .*|splashImage = $SELECTED_PATH;|" "$GRUB_DIR"

elif [[ "$GRUB_SELECTION" == "3" ]]; then
    echo "Seleccione otra imagen para GRUB:"
    for i in "${!IMAGES[@]}"; do
        echo "$((i+1))) ${IMAGES[$i]}"
    done

    read -p "Número de la imagen: " choice

    # Verificar si la elección es válida
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 0 ] || [ "$choice" -ge "${#IMAGES[@]}" ]; then
        echo "Selección inválida."
        exit 1
    fi

    # Obtener el nombre del archivo seleccionado
    SELECTED_IMAGE="${IMAGES[$choice]}"
    SELECTED_PATH="$WALLPAPER_DIR/$SELECTED_IMAGE"

    # Convertir a PNG si no es PNG
    EXT="${SELECTED_IMAGE##*.}"
    FILENAME="${SELECTED_IMAGE%.*}"
    PNG_PATH="$WALLPAPER_DIR/$FILENAME.png"

    if [ "$EXT" != "png" ]; then
        echo "Convirtiendo $SELECTED_IMAGE a PNG..."
        magick "$SELECTED_PATH" "$PNG_PATH"
        SELECTED_PATH="$PNG_PATH"
    fi

    sudo sed -i "s|splashImage = .*|splashImage = $SELECTED_PATH;|" "$GRUB_DIR"


fi

echo "Fondo de pantalla actualizado correctamente."



# Preguntar si quiere hacer nixos-rebuild switch
read -p "¿Desea ejecutar 'nixos-rebuild switch'? (y/N): " REBUILD
echo ""
if [[ "$REBUILD" == "y" || "$REBUILD" == "Y" ]]; then
    sudo nixos-rebuild switch
else
    echo "No se ejecutó nixos-rebuild switch."
fi

# No es neceseario reinicar hyprpaper, porque hay otro script que lo hace automáticamente después del nixos-rebuild switch


