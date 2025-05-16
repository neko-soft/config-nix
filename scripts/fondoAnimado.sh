#!/usr/bin/env bash


VIDEO_DIR="$HOME/wallpapers/animados/resized/"
SCREENS=("HDMI-A-1" "eDP-1")

cd "$VIDEO_DIR" || exit 1

# Obtener lista de archivos .mp4
mapfile -t FILES < <(find . -maxdepth 1 -type f -iname "*.mp4" | sort)

# Salir si no hay archivos
if [ ${#FILES[@]} -eq 0 ]; then
  echo "No hay archivos .mp4 en $VIDEO_DIR"
  exit 1
fi

# Mostrar menú de selección
echo "¿Cuál fondo animado querés usar?"
for i in "${!FILES[@]}"; do
  echo "[$i] ${FILES[$i]#./}"
done

read -rp "Seleccione un número: " CHOICE

# Validar
if [[ ! "$CHOICE" =~ ^[0-9]+$ ]] || (( CHOICE < 0 || CHOICE >= ${#FILES[@]} )); then
  echo "Selección inválida."
  exit 1
fi

SELECTED="${FILES[$CHOICE]#./}"
FULL_PATH="$VIDEO_DIR/$SELECTED"

# Ejecutar mpvpaper en cada pantalla

pkill -f -9 mpvpaper

for SCREEN in "${SCREENS[@]}"; do
  nohup mpvpaper -vs -o "no-audio loop" "$SCREEN" "$FULL_PATH" >/dev/null 2>&1 &
done

echo "Fondo animado configurado: $SELECTED"
