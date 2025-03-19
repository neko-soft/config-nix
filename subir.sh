#!/usr/bin/env bash

# Este script es para copiar los archivos de configuración actuales del sistema
# y subirlos a git

# Lista de carpetas y archivos a respaldar
CONFIG_DIRS=(
    "$HOME/.config/hypr"
    "$HOME/.config/rofi"
    "$HOME/.config/kitty"
    "$HOME/.config/waybar"
    "$HOME/.config/swaylock"
    "$HOME/wallpapers"
    "/etc/nixos"
)

CONFIG_FILES=(
    "$HOME/.bashrc"
)

# Carpeta destino (tu repo de dotfiles)
DEST="$HOME/config-nix"

echo "📂 Copiando configuraciones a $DEST ..."

# Copiar carpetas completas
for DIR in "${CONFIG_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        cp -r "$DIR" "$DEST"
        cp -rL "$DIR" "$HOME/backups"
        echo "📂 Carpeta copiada: $DIR"
    else
        echo "❌ Carpeta no encontrada: $DIR"
    fi
done

#rm -rf $DEST/kitty/kitty-themes
rm $DEST/nixos/hardware-configuration.nix

# Copiar archivos individuales
for FILE in "${CONFIG_FILES[@]}"; do
    if [ -f "$FILE" ]; then
        cp "$FILE" "$DEST"
        echo "✅ Archivo copiado: $FILE"
    else
        echo "❌ Archivo no encontrado: $FILE"
    fi
done

echo "✅ Copia completada."

# Subir cambios a GitHub
cd "$DEST"
git add .
git commit -S -m "Copia automática de dotfiles"
git push origin main




#echo "🚀 Dotfiles subidos a GitHub."
