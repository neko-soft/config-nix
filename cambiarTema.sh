#!/usr/bin/env bash

homeManagerPath="/etc/nixos/homeManager.nix"

# 50% es 80, y 80% es cc porque es en Hexadecimal
opacidad="cc"

colorScript="/home/nekonix/.cache/wal/colors.sh"

if [ ! -f "$colorScript" ]; then
  echo "Error: No se encontró el archivo color.sh."
  exit 1
fi

source "$colorScript"


#echo "$BACKGROUND $FOREGROUND $FRAME_COLOR"


# Verificar si el bloque de configuración existe
if grep -q '^.*\.config/dunst/dunstrc.*text.*=' $homeManagerPath; then
    # Buscar y modificar el bloque específico que contiene 'background ='
    sudo sed -i "/^.*\.config\/dunst\/dunstrc.*text.*=/,/^.*;$/{
        /background =/s/background = .*/background = \"$background$opacidad\"/;
        /foreground =/s/foreground = .*/foreground = \"$foreground\"/;
        /frame_color =/s/frame_color = .*/frame_color = \"$foreground$opacidad\"/;
    }" $homeManagerPath

    
else
    echo "El bloque de configuración de Dunst no se encontró."
fi