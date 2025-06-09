#!/run/current-system/sw/bin/bash

# La idea de este script es que actualice todas las cosas de hyprland, hyprpaper cada vez que se reconstruya el sistema. La idea es dejarlo como un servicio que se ejecute constantemente cuando se reconstruya todo.



        
# Ejecutar Hyprland reload u otros comandos
hyprctl reload



# Esto es para matar el proceso de hyprpaper, esperar que realmente esté muerto, y después reiniciarlo.
# Si se usa homeManager no es necesario tener esto activado
pkill hyprpaper
while pgrep -x "hyprpaper" > /dev/null; do
    sleep 0.5
    echo "Esperando que muera hyprpaper"
done
hyprpaper &



# Esto es para matar el proceso de waybar, esperar que realmente esté muerto, y después reiniciarlo.
# Si se usa homeManager, no es necesario tener esto activado
pkill -9 waybar
while pgrep -x waybar >/dev/null; do
    sleep 0.5
done
waybar &


# Para matar dunst
pkill dunst
while pgrep -x dunst >/dev/null; do
    sleep 0.5
done
dunst &

sleep 2.5
notify-send "🔄 Hyprland, Hyprpaper, Waybar y Dunst recargados."

echo "Comandos post-switch ejecutados."
