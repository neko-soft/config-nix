# 2025-06-17
- [x] Se actualiza script [instalar.sh](scripts/instalar.sh) para que el canal de home manager se edite en el archivo [homeManager.nix](nixos/homeManager.nix) del repositorio descargado y no del archivo local.
- [x] Se actualiza script [refresco.sh](scripts/refresco.sh) para que incluya [adornosTerminal.sh](scripts/adornosTerminal.sh).

# 2025-06-09
- [x] Se agrega al [menuRofi.sh](scripts/menuRofi.sh) una opción para recargar hyprland, hyprpaper, waybar y dunst.
- [x] Se elimina la notificación de temperatura entre 80°C y 90°C, en [temperaturaCpu.sh](scripts/temperaturaCpu.sh), dejando sólo la notificación de alerta sobre los 90°C.

# 2025-06-08
- [x] Se agrega script para silenciar notificaciones [pausarNotificaciones.sh](scripts/pausarNotificaciones.sh).
- [x] Se crea el script [bloqueoPantalla.sh](scripts/bloqueoPantalla.sh) que apaga las notificaciones, y muestra el fondo de pantalla antes de bloquear el sistema.
- [x] Se crea el scripts [menuRofi.sh](scripts/menuRofi.sh) en donde se muestran distintas opciones y acciones que el usuario puede realizar. De momento está la opción de silenciar todas las notificaciones excepto las urgentes, y elegir un fondo de pantalla animado.

# 2025-06-07
- [x] Se agregan módulos de spotify y tiempo (weather) a [waybar.nix](nixos/dotFiles/waybar.nix).
- [x] Se utiliza el script [weather.sh](scripts/weather.sh) para obtener el tiempo según wttr.in.
- [x] Se utiliza el script [currentSongSpotify.sh](scripts/currentSongSpotify.sh) para obtener el nombre de la canción actual sonando en Spotify.

# 2025-06-06
- [x] Se agrega condición a [volumen.sh](scripts/volumen.sh) para evitar subirlo a más del 100%.
- [x] Se modulariza el canal inestable usado en [inestables.nix](nixos/inestables.nix), de tal forma que no es necesario añadirlo con 'nix-channel -add'.
- [x] Home Manager ahora se instala de forma modular, por lo que no es necesario agregarlo como canal con 'nix-channel --add'.
- [x] Se elimina la sección que agrega el canal inestable y home manager en el script [instalar.sh](scripts/instalar.sh) ya que ahora ambos se añaden de forma modular. De todas formas se incluye la opción de que 'nixos' siga el canal estable, inestable o mantener el canal actual para los paquetes en [paquetes.nix](nixos/paquetes.nix).
- [x] Se eliminan varios scripts obsoletos.

# 2025-06-05
- [x] Ajuste de tiempo de espera antes de cambiar velocidad de ventiladores. Antes era 5 segundos, ahora 15 segundos.
- [x] Se corrige [instalar.sh](scripts/instalar.sh) para que siempre instale el canal inestable, independiente de que si el usuario elige el canal estable o no.

# 2025-05-31
- [x] Se crea el script [ventiladores.sh](scripts/ventiladores.sh). Este script controla la velocidad de los ventiladores según al temperatura de la CPU. Este script sólo funciona en laptops OMEN de HP y es muy importante que NO se utlice en otras laptops o dispositivos. Si bien existe un chequeo que verifica el nombre del dispositivo para asegurarse de que sea un OMEN, lo ideal es eliminar el script o comentar su ejecución en [hyprland.nix](nixos/dotFiles/hyprland.nix).

# 2025-05-27
- [x] Se agrega el copiado de archivos de configuración de `glava` en [subir.sh](subir.sh).
- [x] Se agrega el pegado de archivos de configuración de `glava` en [instalar.sh](scripts/instalar.sh).
- [x] Se añaden scripts que muestran notificaciones del estado de la batería (cargado, descargando, llena), alertas de batería baja para menos del 15%, y alertas de temperatura de CPU para valores mayores a 80°C y 90°C. Estos scripts son [estadoBateria.sh](scripts/estadoBateria.sh), [alertaBateria.sh](scripts/alertaBateria.sh) y [temperaturaCpu.sh](scripts/temperaturaCpu.sh) respectivamente.

# 2025-05-26
- [x] Se reordenan los [dotFiles](nixos/dotFiles) de [glava.nix](nixos/dotFiles/glava/glava.nix) de tal forma que queden agrupados en la subcarpeta [nixos/dotFiles/glava](nixos/dotFiles/glava/).

# 2025-05-22
- [x] Se reordenan las tareas pendientes y la estructura del [README.md](README.md).
- [x] Fueron eliminados paquetes y servicios no utilizados, como `MySQL`, `Open Tablet Driver` y `OpenRGB`.
- [x] La configuración [networkAndHost.nix](nixos/networkAndHost.nix) fue reordenada, y se bloquean los pings en IPv4.

# 2025-05-21
- [x] [refresco.sh](scripts/refresco.sh) quedó obsoleto ya que ahora todos los dotFiles se manejan con [homeManager.nix](nixos/homeManager.nix).
- [x] Se elimina `cachix` de [paquetes.nix](nixos/paquetes.nix) al no ser necesario una vez configurando los `substituters` y `trusted-public-keys` en el mismo archivo.
- [x] [agregarCanales.sh](scripts/agregarCanales.sh) quedó obsoleto. Se incorpora todo dentro del nuevo archivo [instalar.sh](scripts/instalar.sh)
- [x] Se añade el script [instalar.sh](scripts/instalar.sh) que copia los archivos del repo al sistema, haciendo todos los cambios necesarios para poder reconstruir NixOS.
- [x] Se elimina [cachix.nix](nixos/cachix.nix) y la carpeta [cachix](nixos/cachix/) al ser incorporados directamente en [paquetes.nix](nixos/paquetes.nix).
- [x] [nixos/respaldo/](nixos/respaldo/) es añadido al `.gitignore`.
