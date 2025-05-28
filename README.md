# Configs de NixOS Personal

En este repo se encuentra la configuración de mi sistema NixOS personal.



# Tareas pendientes

- [ ] Arreglar [README.md](README.md), explicando todo con más detalle, especialmente los [scripts](scripts/). También incluir los atajos de teclado que se usan en [hyprland.nix](nixos/dotFiles/hyprland.nix).
- [ ] Ordenar bien las fuentes en los archivos [paquetes.nix](nixos/paquetes.nix) y [homeManager.nix](nixos/homeManager.nix).
- [ ] Modularizar todo con `flakes`.
- [ ] Crear un script que cambie de fondo de pantalla, y según este, cambie los colores de [hyprland.nix](nixos/dotFiles/hyprland.nix), [waybar](nixos/dotFiles/waybar.nix), [dunst](nixos/dotFiles/dunst.nix), [glava](nixos/dotFiles/glava.nix), [cava](nixos/dotFiles/cava.nix), [kitty](nixos/dotFiles/kitty.nix), [rofi](nixos/dotFiles/rofi.nix) y [swaylock](nixos/dotFiles/swaylock.nix).
- [ ] Agregar en el script [instalar.sh](scripts/instalar.sh) la opción para descargar automáticamente los fondos de pantallas de Google Drive.
- [ ] Mejorar script [instalar.sh](scripts/instalar.sh) para que detecte los canales utilizados actuales, así evitar sobreescribirlos.
- [ ] Reordenar archivos de configuración `.nix` para que exista mayor consistencia con los nombres y sus contenidos.
- [ ] Configurar virtualización para VM con Win11.
- [ ] Agregar home-manager de forma declarativa en vez de agregar el canal manualmente.



# Tareas completas
- [x] Se agrega el copiado de archivos de configuración de `glava` en [subir.sh](subir.sh).
- [x] Se agrega el pegado de archivos de configuración de `glava` en [instalar.sh](scripts/instalar.sh).
- [x] Se añaden scripts que muestran notificaciones del estado de la batería (cargado, descargando, llena), alertas de batería baja para menos del 15%, y alertas de temperatura de CPU para valores mayores a 80°C y 90°C. Estos scripts son [estadoBateria.sh](scripts/estadoBateria.sh), [alertaBateria.sh](scripts/alertaBateria.sh) y [temperaturaCpu.sh](scripts/temperaturaCpu.sh) respectivamente.
  
Para ver todos los cambios, ir a [CHANGELOG.md](CHANGELOG.md)