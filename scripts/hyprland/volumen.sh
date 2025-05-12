#!/usr/bin/env bash


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
esac

VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | grep -o '[0-9]*')
MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [ "$MUTE" = "yes" ]; then
  dunstify -r 91190 -u low "Silenciado" "[░░░░░░░░░░░░░░░░░░░░░░]"
  exit 0
fi

FILLED=$((VOL / 5))
BAR=$(printf '█%.0s' $(seq 1 $FILLED))
EMPTY=$((20 - FILLED))
BAR=$BAR$(printf '░%.0s' $(seq 1 $EMPTY))

dunstify -r 91190 -u low "Volumen $1" "[$BAR] $VOL%"

