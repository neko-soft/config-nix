
#!/usr/bin/env bash


# --- Configuración ---
# URL del archivo oficial de emojis
EMOJI_URL="https://unicode.org/Public/emoji/15.1/emoji-test.txt"
# Ruta donde guardarás el archivo descargado (usa un directorio de cache o config)
EMOJI_FILE="$HOME/emoji/emoji-test.txt"

# --- Asegurarse de que existe el directorio ---
mkdir -p "$(dirname "$EMOJI_FILE")"

# --- Descargar el archivo si no existe ---
if [ ! -f "$EMOJI_FILE" ]; then
    echo "Descargando la lista de emojis desde $EMOJI_URL..."
    if curl -s "$EMOJI_URL" -o "$EMOJI_FILE"; then
        echo "Descarga completa: $EMOJI_FILE"
    else
        echo "Error al descargar el archivo de emojis."
        exit 1
    fi
fi

# --- Procesar el archivo y pasarlo a Rofi ---
# Usamos awk para parsear el archivo:
# -F ';' : Usamos ; como separador principal
# !/^#/ && /#/ : Filtramos líneas que no empiezan con # (comentarios) pero que sí contienen # (donde está el emoji y la descripción)
# { ... } : Bloque de acciones para las líneas que cumplen la condición
# split($2, a, "#") : Dividimos el segundo campo (después del primer ;) usando # como separador. El texto " Emoji Descripción ..." queda en a[2].
# emoji_desc = a[2]; : Guardamos esa parte en una variable.
# gsub(/^[ \t]+|[ \t]+$/,"", emoji_desc); : Limpiamos espacios o tabulaciones al inicio/fin de emoji_desc.
# split(emoji_desc, b, /[ \t]+/); : Dividimos la string limpia por uno o más espacios/tabulaciones. b[1] es el emoji, b[2] en adelante es la descripción.
# printf "%s ", b[1]; : Imprimimos el emoji seguido de un espacio.
# for (i=2; i<=length(b); ++i) printf "%s%s", b[i], (i==length(b) ? "" : " "); : Imprimimos el resto de los campos (la descripción) separados por espacios.
# print "" : Imprimimos un salto de línea para el siguiente emoji.
EMOJI_LIST=$(awk -F ';' '
    !/^#/ && /#/ {
        split($2, a, "#");
        emoji_desc = a[2];
        gsub(/^[ \t]+|[ \t]+$/,"", emoji_desc);
        split(emoji_desc, b, /[ \t]+/);
        printf "%s ", b[1];
        for (i=2; i<=length(b); ++i) printf "%s%s", b[i], (i==length(b) ? "" : " ");
        print ""
    }
' "$EMOJI_FILE")

# Verificar si se generó la lista de emojis
if [ -z "$EMOJI_LIST" ]; then
    echo "Error: No se pudieron extraer emojis del archivo."
    exit 1
fi

# --- Mostrar la lista en Rofi y capturar la selección ---
selected_line=$(echo "$EMOJI_LIST" | rofi -dmenu -i -p "Selecciona un Emoji:" -theme-str 'listview { columns: 2; }') # Ajusta 'columns' si quieres más de 2 columnas

# --- Si se seleccionó algo, extraer el emoji y copiarlo ---
if [ -n "$selected_line" ]; then
    # Extraer solo el primer campo (el emoji) de la línea seleccionada
    selected_emoji=$(echo "$selected_line" | awk '{print $1}')

    if [ -n "$selected_emoji" ]; then
        # Copiar al portapapeles (usa wl-copy para Wayland o xclip para X11)
        # Instala 'wl-copy' (wtype, wayland-clipboard) o 'xclip' si no los tienes
        echo -n "$selected_emoji" | wl-copy || echo -n "$selected_emoji" | xclip -selection clipboard || echo "Error: No se pudo copiar al portapapeles. Instala 'wl-copy' o 'xclip'."
        # echo "Emoji seleccionado '$selected_emoji' copiado al portapapeles." # Descomenta para debugging
    fi
fi

exit 0
