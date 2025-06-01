#!/usr/bin/env bash

BATTERY_PATH="/sys/class/power_supply/BAT0"
THRESHOLD=20
NOTIFY_ID="9999"
ICON="battery-caution-symbolic"



# Función para generar dibujo de batería con bloques
draw_battery_ascii() {
    local percent=$1
    local blocks=$(( percent / 10 ))  # Cada bloque representa 10%
    local bar=""

    for ((i = 0; i < 10; i++)); do
        if (( i < blocks )); then
            bar+="█"
        else
            bar+="░"
        fi
    done

    echo "[${bar}]"
}

while true; do
    capacity=$(cat "$BATTERY_PATH/capacity")
    status=$(cat "$BATTERY_PATH/status")

    if [[ "$capacity" -lt "$THRESHOLD" && "$status" != "Charging" ]]; then
        battery_bar=$(draw_battery_ascii "$capacity")
        dunstify -u critical -r "$NOTIFY_ID" -i "$ICON" \
            " Batería baja " \
            "$battery_bar (${capacity}%)\n¡Conecta el cargador!"
    else
        dunstify -C "$NOTIFY_ID"
    fi

    sleep 5
done

