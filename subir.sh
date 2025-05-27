#!/usr/bin/env bash


# --- Configuración ---

# Directorio de destino para la copia (donde está el script de respaldo)
DEST="$(dirname "$(realpath "$0")")"

# Lista de carpetas a respaldar (sin /etc/nixos aquí)
CONFIG_DIRS=(
    #"$HOME/.config/hypr"
    #"$HOME/.config/rofi"
    #"$HOME/.config/kitty"
    #"$HOME/.config/waybar"
    #"$HOME/.config/swaylock"
    #"/home/nekonix/wallpapers" # Asumiendo que quieres respaldar todo el contenido
    #"$HOME/.config/glava"
    # /etc/nixos lo manejaremos aparte por la exclusion
)

# Lista de archivos individuales a respaldar
CONFIG_FILES=(
    "/home/nekonix/.bashrc"
)

# --- Proceso de Copia (Todo con rsync) ---

echo "📂 Copiando configuraciones a $DEST ..."
sudo rm -rf "$DEST/nixos/"

# Copiar /etc/nixos usando rsync para excluir hardware-configuration.nix
# rsync -a: modo archivo (mantiene permisos, timestamps, enlaces, recursivo)
# --exclude='hardware-configuration.nix': excluye especificamente este archivo
# "/etc/nixos/": Origen (la barra al final es importante con rsync)
# "$DEST/nixos/": Destino (rsync creara la carpeta nixos si no existe)
# sudo: necesario para leer /etc/nixos
echo "📂 Copiando /etc/nixos (excluyendo hardware-configuration.nix) con rsync..."
if sudo rsync -a --exclude='hardware-configuration.nix' "/etc/nixos/" "$DEST/nixos/"; then
    echo "✅ /etc/nixos copiado (con exclusion) con rsync."
else
    echo "❌ Error al copiar /etc/nixos con exclusion. Revisa permisos o si rsync esta instalado."
    # Puedes decidir si salir aqui o continuar con el resto de las copias
    # exit 1
fi


# Copiar las otras carpetas completas usando rsync -a
# rsync -a: modo archivo (mantiene permisos, timestamps, enlaces, recursivo). Copia symlinks como symlinks.
# "$DIR": Origen de la carpeta.
# "$DEST/": Destino. rsync copiara la carpeta de origen dentro de DEST.
for DIR in "${CONFIG_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        echo "📂 Copiando carpeta con rsync: $DIR"
        # sudo necesario si algunas carpetas lo requieren
        # El / al final de "$DEST/" asegura que copie la carpeta de origen dentro del destino
        if sudo rsync -a "$DIR" "$DEST/"; then
             echo "✅ Carpeta copiada con rsync: $DIR"
        else
             echo "❌ Error al copiar carpeta con rsync: $DIR"
        fi
    else
        echo "⚠️ Carpeta no encontrada (se omite): $DIR"
    fi
done


# Copiar archivos individuales usando rsync
# rsync "$FILE": Origen del archivo
# "$DEST/": Destino. rsync copiara el archivo de origen dentro de DEST.
for FILE in "${CONFIG_FILES[@]}"; do
    if [ -f "$FILE" ]; then
        echo "📂 Copiando archivo con rsync: $FILE"
        # sudo podria ser necesario si el archivo requiere permisos
        # El / al final de "$DEST/" asegura que copie el archivo dentro del destino
        if rsync "$FILE" "$DEST/"; then
            echo "✅ Archivo copiado con rsync: $FILE"
        else
            echo "❌ Error al copiar archivo con rsync: $FILE"
        fi
    else
        echo "⚠️ Archivo no encontrado (se omite): $FILE"
    fi
done

echo "✅ Proceso de copia completado con rsync (excluyendo hardware-configuration.nix)."

# --- Proceso de Git ---

#echo "Mensaje del commit:" # Descomentame si quieres un mensaje manual
#read MENSAJE             # Descomentame si quieres un mensaje manual

cd "$DEST" || { echo "Error: No se pudo acceder al directorio de destino para Git"; exit 1; } # Asegura que estamos en el destino

echo "📦 Añadiendo cambios a Git..."
git add .

# Usa el mensaje leido si descomentaste las lineas anteriores, si no, usa el mensaje automatico
# MENSAJE_FINAL=${MENSAJE:-"Actualización de archivos $(date +"%Y-%m-%d %H:%M:%S")"}
# git commit -S -m "$MENSAJE_FINAL"

echo "📝 Creando commit firmado..."
# Commit firmado con mensaje automatico
if git commit -S -m "Actualización de archivos $(date +"%Y-%m-%d %H:%M:%S")"; then
    echo "✅ Commit creado."
else
    echo "❌ Error al crear el commit. Puede que no haya cambios o haya problemas con la firma (-S)."
    # Decide si quieres salir aqui si no hay commit que subir
    # exit 1
fi


echo "🚀 Subiendo cambios a GitHub..."
# git push origin main
# Puedes añadir manejo de errores aqui tambien si falla el push
if git push origin main; then
    echo "✅ Dotfiles subidos a GitHub."
else
    echo "❌ Error al subir a GitHub. Revisa tu conexión o permisos."
    exit 1 # Salir con error si el push falla
fi