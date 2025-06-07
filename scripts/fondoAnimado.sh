#!/usr/bin/env bash

# --- Configuración ---
VIDEO_DIR="$HOME/wallpapers/animados/resized"
SCREENS=("HDMI-A-1" "eDP-1")

# --- Navegar al directorio de videos ---
cd "$VIDEO_DIR" || { echo "Error: No se pudo acceder al directorio $VIDEO_DIR"; exit 1; }

# --- Buscar archivos .mp4 y ordenarlos ---
mapfile -t FILES < <(find . -maxdepth 1 -type f -iname "*.mp4" | sort)

# --- Salir si no hay archivos encontrados ---
if [ ${#FILES[@]} -eq 0 ]; then
    echo "No hay archivos .mp4 en $VIDEO_DIR"
    exit 1
fi

# --- Mostrar lista numerada ---
echo "Selecciona un fondo animado:"
for i in "${!FILES[@]}"; do
    filename="${FILES[$i]#./}"  # Elimina "./" si está presente
    printf "%3d) %s\n" $((i+1)) "$filename"
done

# --- Leer selección del usuario ---
read -rp "Número (1-${#FILES[@]}): " selection

# --- Validar selección ---
if ! [[ "$selection" =~ ^[0-9]+$ ]] || (( selection < 1 || selection > ${#FILES[@]} )); then
    echo "Selección inválida."
    exit 1
fi

# --- Obtener archivo seleccionado ---
selected_filename="${FILES[$((selection-1))]#./}"
FULL_PATH="$VIDEO_DIR/$selected_filename"

# --- Matar instancias anteriores de mpvpaper ---
echo "Deteniendo mpvpaper..."
pkill -f -9 mpvpaper
sleep 0.5

# --- Ejecutar mpvpaper en cada pantalla ---
echo "Configurando fondo animado: $selected_filename en ${#SCREENS[@]} pantalla(s)..."
for SCREEN in "${SCREENS[@]}"; do
    nohup mpvpaper -vs -o "no-audio loop" "$SCREEN" "$FULL_PATH" >/dev/null 2>&1 &
done

echo "¡Listo!"
