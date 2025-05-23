#!/usr/bin/env bash

# Glifos Nerd Font fijos
ICON_UP="󰕿"
ICON_DOWN="󰕿"
ICON_MUTE="󰕿"

# Función para generar barra visual
gen_bar() {
  local vol=$1
  local filled=$((vol / 5))
  local empty=$((20 - filled))
  printf '█%.0s' $(seq 1 $filled)
  printf '░%.0s' $(seq 1 $empty)
}

# Lógica de control
case "$1" in
  up)
    pactl set-sink-volume @DEFAULT_SINK@ +1%
    ;;
  down)
    pactl set-sink-volume @DEFAULT_SINK@ -1%
    ;;
  mute)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    ;;
  *)
    exit 1
    ;;
esac

# Obtener estado actual
VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | grep -o '[0-9]*')
MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
BAR=$(gen_bar "$VOL")

# Mostrar notificación según estado
if [ "$MUTE" = "yes" ]; then
  dunstify -r 91190 -u low "Silenciado $ICON_MUTE" "[░░░░░░░░░░░░░░░░░░░░░░] 0%"
else
  case "$1" in
    up)
      dunstify -r 91190 -u low "Volumen $ICON_UP" "[$BAR] $VOL%"
      ;;
    down)
      dunstify -r 91190 -u low "Volumen $ICON_DOWN" "[$BAR] $VOL%"
      ;;
    mute)
      dunstify -r 91190 -u low "Volumen $ICON_UP" "[$BAR] $VOL%"
      ;;
  esac
fi
