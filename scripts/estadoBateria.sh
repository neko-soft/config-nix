#!/usr/bin/env bash

BATTERY_PATH="/sys/class/power_supply/BAT0"
NOTIFY_ID="8888"
LAST_STATUS=""


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
    # Leer el estado actual
    if [[ -f "$BATTERY_PATH/status" ]]; then
        STATUS=$(cat "$BATTERY_PATH/status")
    else
        echo "No se encontró el archivo de estado de batería"
        exit 1
    fi

    if [[ "$STATUS" != "$LAST_STATUS" ]]; then
        capacity=$(cat "$BATTERY_PATH/capacity")
        battery_bar=$(draw_battery_ascii "$capacity")
        case "$STATUS" in
            "Charging")
                dunstify -r "$NOTIFY_ID" -u normal -i "battery-good-symbolic" "󱐥 Cargador conectado 󱐥" "󰢝 Batería cargándose 󰢝\n$battery_bar (${capacity}%)"
                ;;
            "Discharging")
                dunstify -r "$NOTIFY_ID" -u normal -i "battery-empty-symbolic" "󱐤 Cargador desconectado 󱐤" "󰁾 Batería descargándose 󰁾\n$battery_bar (${capacity}%)"
                ;;
            "Full")
                dunstify -r "$NOTIFY_ID" -u normal -i "battery-full-symbolic" "󰂄 Batería llena 󰂄" "$battery_bar (${capacity}%)"
                ;;
        esac
        LAST_STATUS="$STATUS"
    fi

    sleep 5  # Chequeo rápido, pero no demasiado frecuente
done
