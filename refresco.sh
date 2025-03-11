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
        pkill hyprpaper

        while pgrep -x "hyprpaper" > /dev/null; do
            sleep 1
            echo "Esperando que muera hyprpaper"
        done
        echo "Reiniciando Hyprpaper..."
        hyprpaper &
        echo "Hyprpaper reiniciado :D"
        
        echo "Comandos post-switch ejecutados."
    fi

    # Esperar antes de volver a verificar
    sleep 10
done
