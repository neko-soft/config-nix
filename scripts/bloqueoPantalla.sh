#!/usr/bin/env bash

~/config-nix/scripts/mostrarFondo.sh

STATUS_FILE="$HOME/.cache/dunst_paused"
WAS_ALREADY_MUTED=false

if [[ -f "$STATUS_FILE" ]]; then
    WAS_ALREADY_MUTED=true
else
    dunstctl close-all
    dunstctl set-paused true
    touch "$STATUS_FILE"
fi

# Bloquear pantalla (esto pausa el script hasta que se desbloquee)
# Lanzar swaylock en background
swaylock &

# Esperar hasta que swaylock termine
while pgrep -x swaylock >/dev/null; do
    sleep 0.5
done
~/config-nix/scripts/mostrarFondo.sh


# Restaurar notificaciones solo si las muteamos nosotros
if [[ "$WAS_ALREADY_MUTED" == "false" ]]; then
    dunstctl set-paused false
    rm -f "$STATUS_FILE"
    notify-send "🔔 Notificaciones reactivadas"
fi
