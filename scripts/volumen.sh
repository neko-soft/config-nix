#!/usr/bin/env bash


ICON=""
ICON_MUTE=""

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
    VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | grep -o '[0-9]*')
    if [ "$VOL" -lt 100 ]; then
      pactl set-sink-volume @DEFAULT_SINK@ +1%
      VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | grep -o '[0-9]*')
      if [ "$VOL" -eq 100 ]; then
        dunstify -r 91190 -u low "Volumen al máximo $ICON " "[████████████████████] $VOL%"
        exit 0
      fi
    else
      dunstify -r 91190 -u low "Volumen al máximo $ICON " "[████████████████████] $VOL%"
      exit 0
    fi
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
  dunstify -r 91190 -u low "Silenciado $ICON_MUTE " "[░░░░░░░░░░░░░░░░░░░░░░] 0%"
else
  case "$1" in
    up)
        dunstify -r 91190 -u low "Volumen $ICON " "[$BAR] $VOL%"
      ;;
    down)
      dunstify -r 91190 -u low "Volumen $ICON " "[$BAR] $VOL%"
      ;;
    mute)
      dunstify -r 91190 -u low "Volumen $ICON " "[$BAR] $VOL%"
      ;;
  esac
fi