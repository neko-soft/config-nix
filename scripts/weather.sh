#!/usr/bin/env bash

LOCATION="${1:-}"
BASE_URL="https://wttr.in/${LOCATION}"
TZ_OFFSET="-0400"

# Obtener amanecer, atardecer y hora actual
read -r sunrise sunset now <<< "$(curl -s "${BASE_URL}?format=%S+%s+%T")"

# Convertir a segundos
to_seconds() {
    date -d "$1" +%s 2>/dev/null || gdate -d "$1" +%s
}

sunrise_s=$(to_seconds "${sunrise}${TZ_OFFSET}")
sunset_s=$(to_seconds "${sunset}${TZ_OFFSET}")
now_s=$(to_seconds "$now")

# Elegir modo día o noche
if [[ $now_s -ge $sunrise_s && $now_s -lt $sunset_s ]]; then
    mode="v2d"
else
    mode="v2n"
fi

# Obtener y procesar el clima
for i in {1..3}; do
    raw=$(curl -s "${BASE_URL}?format=${mode}" | grep -m1 'Weather:')
    #echo "RAW: $raw"
    #echo "$raw" | od -c

    clean=$(echo "$raw" | sed -r 's/\x1B\[[0-9;]*[mK]//g' | sed -E 's/^Weather:[[:space:]]+//')

    #echo "CLEAN: $clean"

    if [[ -n "$clean" ]]; then
        glyph=$(echo "$clean" | awk '{print $1}')
        #echo "GLYPH: $glyph"
        temp=$(echo "$clean" | grep -oE '[+-][0-9]+°C')
        #echo "TEMP: $temp"
        echo "{\"text\": \"${glyph} ${temp}\", \"tooltip\": \"${clean}\"}"
        exit 0
    fi

    sleep 1
done

# Error
echo '{"text": "", "tooltip": "wttr.in error"}'
