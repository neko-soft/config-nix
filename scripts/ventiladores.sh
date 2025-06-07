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

# Configuración de Curva y la histérica
# Define el valor de histéresis en grados Celsius.
# Esto crea una "zona de tolerancia" para evitar cambios rápidos de velocidad.
# Por ejemplo, si es 3°C, el ventilador solo bajará de velocidad si la temperatura
# cae 3°C por debajo del umbral de bajada.
HYSTERESIS_C=3


# Variables para la lógica de histéresis:
# last_applied_fan_hex: Almacena el último valor HEX de velocidad que fue aplicado a los ventiladores.
# last_applied_upper_threshold: Almacena el umbral superior de temperatura (en °C) de la *última*
#                               velocidad aplicada. Esto es crucial para decidir cuándo bajar la velocidad.
last_applied_fan_hex=""
last_applied_upper_threshold=0 # Se inicializa a 0, se actualizará en la primera pasada.

# 1. Desactivar control del BIOS
echo "Desactivando control de ventiladores del BIOS..."
write_ec "06" $REG_BIOS1
write_ec "00" $REG_BIOS2
echo "Control de ventiladores en modo manual."

while true; do

    # 2. Leer la temperatura actual de la CPU usando `sensors`
    # `awk` se usa para extraer el valor numérico de la temperatura Tctl (CPU)
    TEMP_C=$(sensors | awk '/Tctl:/ {gsub("\\+|°C",""); print int($2)}')

    # 3. Decidir la velocidad objetivo (en HEX) y su umbral superior asociado
    #    Esta es la velocidad que *debería* tener el ventilador según la temperatura actual
    #    sin considerar la histéresis todavía.
    target_fan_hex=""
    target_upper_threshold=0 # El umbral de temperatura superior para esta velocidad objetivo

    if [ "$TEMP_C" -lt 40 ]; then
        target_fan_hex="16"
        target_upper_threshold=40 # El ventilador debería subir a 0B a 40°C
    elif [ "$TEMP_C" -lt 60 ]; then
        target_fan_hex="1b"
        target_upper_threshold=60 # El ventilador debería subir a 1B a 55°C
    elif [ "$TEMP_C" -lt 80 ]; then
        target_fan_hex="20"
        target_upper_threshold=80 # El ventilador debería subir a 26 a 70°C
    elif [ "$TEMP_C" -lt 90 ]; then
        target_fan_hex="30"
        target_upper_threshold=90 # El ventilador debería subir a 37 a 85°C
    else # Si la temperatura es 85°C o más
        target_fan_hex="37" # Poner ventiladores al máximo (5500 RPM)
        target_upper_threshold=1000 # Un valor muy alto, indica que ya estamos en el rango superior
    fi

    # --- Lógica de Histéresis ---
    # Esta sección decide si se debe aplicar la nueva velocidad o mantener la anterior
    # para evitar fluctuaciones rápidas.

    perform_fan_update=false # Bandera para indicar si se debe actualizar la velocidad

    if [[ -z "$last_applied_fan_hex" ]]; then
        # Primera ejecución del script: siempre aplicar la velocidad objetivo.
        perform_fan_update=true
    elif [[ "$target_fan_hex" > "$last_applied_fan_hex" ]]; then
        # La velocidad objetivo es mayor que la última aplicada (la temperatura está subiendo o necesita más refrigeración).
        # Siempre aumentar la velocidad inmediatamente para proteger la CPU.
        perform_fan_update=true
    elif [[ "$target_fan_hex" < "$last_applied_fan_hex" ]]; then
        # La velocidad objetivo es menor que la última aplicada (la temperatura está bajando).
        # Solo reducir la velocidad si la temperatura actual está *significativamente* por debajo
        # del umbral superior de la *última velocidad aplicada*, considerando la histéresis.
        if (( TEMP_C < (last_applied_upper_threshold - HYSTERESIS_C) )); then
            perform_fan_update=true
        fi
    fi
    # Si target_fan_hex es igual a last_applied_fan_hex, perform_fan_update seguirá siendo 'false',
    # lo que significa que la velocidad no cambiará, que es el comportamiento deseado.

    if $perform_fan_update; then
        # Si se decide actualizar la velocidad:
        # 4. Aplicar la velocidad objetivo a ambos ventiladores
        write_ec "$target_fan_hex" $REG_FAN1
        write_ec "$target_fan_hex" $REG_FAN2

        # Actualizar las variables de histéresis para la próxima iteración
        last_applied_fan_hex="$target_fan_hex"
        last_applied_upper_threshold="$target_upper_threshold"

        # Log de la acción
        echo "🌡 Temp: $TEMP_C°C → Fans: 0x$target_fan_hex (ACTUALIZADO)"
    else
        # Si no se actualiza la velocidad (histéresis activa), solo se registra el estado actual.
        echo "🌡 Temp: $TEMP_C°C → Fans: 0x$last_applied_fan_hex (NO CAMBIADO, histéresis activa)"
    fi

    # Esperar 15 segundos antes de la próxima comprobación
    sleep 15

done
