#!/usr/bin/env bash

VIDEO_DIR="$HOME/wallpapers/animados/resized"
SCREENS=("HDMI-A-1" "eDP-1")

cd "$VIDEO_DIR" || {
  notify-send "Error" "No se pudo acceder a $VIDEO_DIR"
  exit 1
}

mapfile -t FILES < <(find . -maxdepth 1 -type f -iname "*.mp4" | sort)

if [ ${#FILES[@]} -eq 0 ]; then
  notify-send "Sin archivos" "No hay videos en $VIDEO_DIR"
  exit 1
fi

# --- Crear lista limpia para mostrar ---
OPTIONS=$(printf "%s\n" "${FILES[@]#./}")

# --- Mostrar menú con rofi ---
CHOSEN=$(printf "%s\n" "$OPTIONS" | rofi -dmenu -i -p "Elige fondo animado")

# --- Validar selección ---
[[ -z "$CHOSEN" ]] && exit 0  # cancelado

FULL_PATH="$VIDEO_DIR/$CHOSEN"

# --- Matar instancias anteriores de mpvpaper ---
pkill -f -9 mpvpaper
sleep 0.5

# --- Ejecutar fondo en pantallas ---
for SCREEN in "${SCREENS[@]}"; do
  nohup mpvpaper -vs -o "no-audio loop" "$SCREEN" "$FULL_PATH" >/dev/null 2>&1 &
done

notify-send "🎞️ Fondo aplicado" "$CHOSEN"
