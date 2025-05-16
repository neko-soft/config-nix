#!/usr/bin/env bash

#!/usr/bin/env bash

# Archivo temporal para guardar el índice del ícono actual
ICON_FILE="/tmp/volume_icon"

# Glifos Nerd Font para volumen
ICONS=(  )



# Obtener índice actual
get_current_index() {
  [[ -f "$ICON_FILE" ]] && cat "$ICON_FILE" || echo 0
}

# Guardar nuevo índice
save_index() {
  echo "$1" > "$ICON_FILE"
}

# Obtener índice actual
index=$(get_current_index)

# Modificar volumen e índice
case "$1" in
  up)
    pactl set-sink-volume @DEFAULT_SINK@ +1%
    index=$(( (index + 1) % 3 ))
    ;;
  down)
    pactl set-sink-volume @DEFAULT_SINK@ -1%
    index=$(( (index - 1 + 3) % 3 ))  # evita valores negativos
    ;;
  mute)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    index=0
    ;;
  *)
    exit 1
    ;;
esac

save_index "$index"

# Obtener estado de volumen y muteo
VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | grep -o '[0-9]*')
MUTE=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# Notificación de muteo
if [ "$MUTE" = "yes" ]; then
  dunstify -r 91190 -u low "󰖁 Silenciado" "[░░░░░░░░░░░░░░░░░░░░░░] 0%"
  exit 0
fi

# Generar barra de volumen visual
FILLED=$((VOL / 5))
BAR=$(printf '█%.0s' $(seq 1 $FILLED))
EMPTY=$((20 - FILLED))
BAR=$BAR$(printf '░%.0s' $(seq 1 $EMPTY))

# Mostrar notificación
ICON=${ICONS[$index]}
dunstify -r 91190 -u low "Volumen $ICON" "[$BAR] $VOL%"
