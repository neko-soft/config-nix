#!/run/current-system/sw/bin/bash

# La idea de este script es que actualice todas las cosas de hyprland, hyprpaper cada vez que se reconstruya el sistema. La idea es dejarlo como un servicio que se ejecute constantemente cuando se reconstruya todo.

echo "Monitoreando sudo nixos-rebuild switch..."

while true; do
    # Verifica si el comando está corriendo como root
    if pgrep -xaf "sudo nixos-rebuild switch" > /dev/null; then
        echo "Detectado sudo nixos-rebuild switch, esperando a que termine..."
        

        # Esperar a que termine
        while pgrep -xaf "sudo nixos-rebuild switch" > /dev/null; do
            sleep 5
        done
        
        echo "nixos-rebuild switch finalizado. Ejecutando comandos post-switch..."
        
        # Ejecutar Hyprland reload u otros comandos
        hyprctl reload

        # Esto es para matar el proceso de hyprpaper, esperar que realmente esté muerto, y después reiniciarlo.
        pkill hyprpaper
        while pgrep -x "hyprpaper" > /dev/null; do
            sleep 0.5
            echo "Esperando que muera hyprpaper"
        done
        hyprpaper &


        # Esto es para matar el proceso de waybar, esperar que realmente esté muerto, y después reiniciarlo.
	# Si se usa homeManager, no es necesario tener esto activado
        #pkill waybar
        #while pgrep -x waybar >/dev/null; do
        #    sleep 0.5
        #done
        #waybar &

        # Para matar dunst
        pkill dunst
        while pgrep -x dunst >/dev/null; do
            sleep 0.5
        done
        dunst &

        echo "Comandos post-switch ejecutados."
    fi

    # Esperar antes de volver a verificar
    sleep 10
done
