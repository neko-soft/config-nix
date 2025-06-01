#!/usr/bin/env bash

# ESTE SCRIPT NO DEBE USADO EN DISPOSITIVOS QUE NO SEAN LAPTOPS OMEN.
# USAR ESTE SCRIPT EN OTROS DISPOSITIVOS PUEDE CAUSAR DAÑOS
# IRREPATARBLES DEBIDO A LOS CAMBIOS DE BAJO NIVEL QUE SE EJECUTAN


if ! grep -qi "omen" /sys/class/dmi/id/product_name; then
  echo "❌ No es un HP OMEN. Abortando script de ventiladores para evitar daños."
  exit 1
fi


# Ruta EC
EC="/sys/kernel/debug/ec/ec0/io"

# Registros
REG_FAN1=52
REG_FAN2=53
REG_BIOS1=98
REG_BIOS2=99

# Función: escribir valor hex a registro EC
write_ec() {
  local hex=$1
  local reg=$2
  printf "\\x$hex" | sudo dd of=$EC bs=1 seek=$reg count=1 status=none
}

# 1. Desactivar control del BIOS
write_ec "06" $REG_BIOS1
write_ec "00" $REG_BIOS2

while true; do

    # 2. Leer temperatura desde `sensors`
    TEMP_C=$(sensors | awk '/Tctl:/ {gsub("\\+|°C",""); print int($2)}')

    # 3. Decidir velocidad (en HEX)
    if [ "$TEMP_C" -lt 60 ]; then
    FAN_HEX="10"
    elif [ "$TEMP_C" -lt 70 ]; then
    FAN_HEX="20"
    elif [ "$TEMP_C" -lt 80 ]; then
    FAN_HEX="25"
    elif [ "$TEMP_C" -lt 90 ]; then
    FAN_HEX="30"
    else
    FAN_HEX="37"
    fi

    # 4. Aplicar velocidad a ambos ventiladores
    write_ec "$FAN_HEX" $REG_FAN1
    write_ec "$FAN_HEX" $REG_FAN2

    # Log
    echo "🌡 Temp: $TEMP_C°C → Fans: 0x$FAN_HEX"

    sleep 30

done
