#!/usr/bin/env bash

# La idea de este script es que actualice todas las cosas de hyprland, hyprpaper cada vez que se reconstruya el sistema. La idea es dejarlo como un servicio que se ejecute constantemente cuando se reconstruya todo.

/run/current-system/sw/bin/hyprctl reload
pkill hyprpaper

# Esto es porque el pkill se demora un poco en matar el hyprpaper, así que espera hasta que realmente esté muerto antes de seguir, porque si no, te va a tirar un error que dice que no puedes tener varias instancias de hyprpaper al mismo tiempo.4
while pgrep -x hyprpaper >/dev/null; do
    sleep 0.1
done

hyprpaper &

