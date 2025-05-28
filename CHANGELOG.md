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
