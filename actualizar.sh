#!/usr/bin/env bash

# Directorio donde se clonaron los dotfiles
DOTFILES_DIR="$HOME/config-nix"

# Archivos y carpetas a copiar
FILES=(
    ".bashrc"
    "Kath.png"
)

CONFIGDIR=(
    "kitty"
    "hypr"
    "rofi"
    "swaylock"
    "waybar"
)



# Crear backup y copiar archivos/carpetas
echo "🔹 Copiando dotfiles desde $DOTFILES_DIR..."

for folder in "${CONFIGDIR[@]}"; do
    src="$DOTFILES_DIR/$folder"
    dest="$HOME/tomate"

    cp -r "$src" "$dest"

    echo "✅ Copiado: $dest/$folder"
done

# Este copia los archivos de NixOS
sudo cp -r "$DOTFILES_DIR/nixos" "$HOME/tomate"
echo "✅ Copiado: /etc/tomate/nixos"




#for file in "${FILES[@]}"; do
#    src="$DOTFILES_DIR/$file"
#    dest="$HOME/$file"

    # Verificar si el archivo/carpeta existe en el destino
#    if [ -e "$dest" ] || [ -d "$dest" ]; then
#        echo "📌 Backup creado: $dest.bak"
#        mv "$dest" "$dest.bak"
#    fi

#     Si es un directorio, copiar con -r
#    if [ -d "$src" ]; then
#        cp -r "$src" "$dest"
#    else
#        cp "$src" "$dest"
#    fi

#    echo "✅ Copiado: $file"
#done

echo "🎉 Dotfiles instalados con éxito."
