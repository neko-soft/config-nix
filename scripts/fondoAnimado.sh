#!/usr/bin/env bash

# --- Configuración ---
VIDEO_DIR="$HOME/wallpapers/animados/resized" # Directorio de wallpapers
SCREENS=("HDMI-A-1" "eDP-1")                 # Nombres de tus pantallas
ROFI_PROMPT="Selecciona un fondo animado:"   # Título del menú de Rofi

# --- Navegar al directorio de videos ---
# Asegura que el script pare si no puede entrar
cd "$VIDEO_DIR" || { echo "Error: No se pudo acceder al directorio $VIDEO_DIR"; exit 1; }

# --- Buscar archivos .mp4 y ordenarlos ---
# Busca .mp4 (ignorando mayus/minus) solo en el directorio actual y guarda la lista en el array FILES
mapfile -t FILES < <(find . -maxdepth 1 -type f -iname "*.mp4" | sort)

# --- Salir si no hay archivos encontrados ---
if [ ${#FILES[@]} -eq 0 ]; then
    echo "No hay archivos .mp4 en $VIDEO_DIR"
    exit 1
fi

# --- Preparar la lista para Rofi ---
# Rofi -dmenu espera una lista de items en su entrada estándar, uno por línea.
# Eliminamos el "./" del inicio de cada nombre de archivo.
ROFI_LIST=""
for file_path in "${FILES[@]}"; do
    filename="${file_path#./}" # Elimina "./" del inicio
    ROFI_LIST+="$filename"$'\n' # Añade el nombre y un salto de línea
done

# Elimina el último salto de línea para evitar un item vacío en Rofi
ROFI_LIST=${ROFI_LIST%?}

# --- Mostrar el menú de Rofi y capturar la selección ---
# Envía la lista a Rofi en modo dmenu.
# -i: búsqueda insensible a mayúsculas/minúsculas.
# -p: establece el texto del prompt.
# Captura la selección en la variable selected_filename.
selected_filename=$(echo "$ROFI_LIST" | rofi -dmenu -i -p "$ROFI_PROMPT")

# --- Verificar si el usuario seleccionó un archivo o canceló ---
# Si la variable selected_filename está vacía, el usuario canceló (Escape).
if [ -z "$selected_filename" ]; then
    echo "Selección cancelada."
    exit 0 # Salir limpiamente
fi

# --- Construir la ruta completa del archivo seleccionado ---
FULL_PATH="$VIDEO_DIR/$selected_filename"

# --- Matar cualquier instancia anterior de mpvpaper ---
# Busca procesos que contengan 'mpvpaper' y los mata forzadamente (-9).
echo "Deteniendo mpvpaper..."
pkill -f -9 mpvpaper

# Pequeña pausa para asegurar que los procesos mueran
sleep 0.5

# --- Ejecutar mpvpaper en cada pantalla ---
# Configura mpvpaper para cada pantalla definida en el array SCREENS.
# -vs: video-sync mode.
# -o "no-audio loop": opciones de mpv (sin audio, repetir).
# >/dev/null 2>&1: silencia la salida de mpvpaper.
# &: ejecuta el comando en segundo plano.
# nohup ... &: asegura que el proceso continúe después de cerrar la terminal.
echo "Configurando fondo animado: $selected_filename en ${#SCREENS[@]} pantalla(s)..."
for SCREEN in "${SCREENS[@]}"; do
    nohup mpvpaper -vs -o "no-audio loop" "$SCREEN" "$FULL_PATH" >/dev/null 2>&1 &
done

echo "¡Listo!"