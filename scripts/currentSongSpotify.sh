#!/usr/bin/env bash

icon=""
cache_file="/tmp/spotify_last_title"

# Obtener el título de la ventana Spotify
title=$(hyprctl clients -j | jq -r '.[] | select(.class=="Spotify") | .title' | head -n 1)

# Si el título existe y no es simplemente "Spotify", guardarlo
if [[ -n "$title" && "$title" != "Spotify Premium" ]]; then
    echo "$title" > "$cache_file"
    echo "{\"text\": \"$icon $title\", \"tooltip\": \"$title\"}"
    exit 0
fi

# Si el título es "Spotify", pero hay uno guardado, usar ese
if [[ "$title" == "Spotify Premium" && -f "$cache_file" ]]; then
    last_title=$(cat "$cache_file")
    echo "{\"text\": \"$icon $last_title\", \"tooltip\": \"$last_title\"}"
    exit 0
fi

# Si no hay nada válido, ocultar el módulo
echo ""

