#!/usr/bin/env bash

# Directorio donde se clonaron los dotfiles
DOTFILES_DIR="$HOME/config-nix"

echo "🔹 Copiando dotfiles desde $DOTFILES_DIR..."

# Archivos y carpetas a copiar
FILES=(
    ".bashrc"
    "Kath.png"
)

# Este copia los archivos sueltos que van en $HOME
for file in "${FILES[@]}"; do
    src="$DOTFILES_DIR/$file"
    dest="$HOME/$file"

    cp "$src" "$dest"

    echo "✅ Copiado: $dest"
done

CONFIGDIR=(
    "kitty"
    "hypr"
    "rofi"
    "swaylock"
    "waybar"
)

# Este copia principalmente los directorios que van al ~/.config
for folder in "${CONFIGDIR[@]}"; do
    src="$DOTFILES_DIR/$folder"
    dest="$HOME/.config"

    cp -r "$src" "$dest"

    echo "✅ Copiado: $dest/$folder"
done

# Este copia los archivos de NixOS
sudo cp -r "$DOTFILES_DIR/nixos" "/etc"
echo "✅ Copiado: /etc/nixos"



echo "🎉 Dotfiles instalados con éxito."
