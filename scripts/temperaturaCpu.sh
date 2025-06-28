#!/usr/bin/env bash

NOTIFY_ID="7777"

# Función para obtener la temperatura más alta de la CPU
get_cpu_temp() {
    # Requiere 'sensors' del paquete lm_sensors
    sensors | awk '/Tctl:/ { gsub(/\+|°C/, "", $2); print int($2) }'
}

while true; do
    temp=$(get_cpu_temp)

    if [[ -z "$temp" ]]; then
        echo "No se pudo obtener la temperatura de la CPU"
        exit 1
    fi

    if (( temp >= 95 )); then
        dunstify -u normal -r "$NOTIFY_ID" -i "dialog-warning" \
            "🔥 CPU HIRVIENDO: $temp °C 🔥" \
            "🥵 El procesador está muy caliente 🥵"
    #elif (( temp >= 80 )); then
    #    dunstify -u normal -r "$NOTIFY_ID" -i "dialog-warning" \
    #        "󰀦 Temperatura alta: $temp °C " \
    #        "El procesador se está calentando."
    else
        # Cerrar notificación si ya no aplica
        dunstify -C "$NOTIFY_ID"
    fi

    sleep 1
done
