#!/usr/bin/env bash

chosen=$(printf "🔕 Toggle Notificaciones\n🎞️ Elegir fondo animado\n" | rofi -dmenu -i -p "Acciones")
case "$chosen" in

  "🔕 Toggle Notificaciones")
    ~/config-nix/scripts/pausarNotificaciones.sh
    ;;

  "🎞️ Elegir fondo animado")
    ~/config-nix/scripts/fondoAnimado.sh
    ;;

esac


}