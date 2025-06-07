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
- [x] Agregar home-manager de forma declarativa en vez de agregar el canal manualmente.
- [x] Agregar condición a [volumen.sh](scripts/volumen.sh) para evitar subir el volumen a más del 100%.
- [ ] Agregar icon trays a [waybar.nix](nixos/dotFiles/waybar.nix).
- [ ] Agregar un ícono que permita pausar las notificaciones de [dunst.nix](nixos/dotFiles/dunst.nix) temporalmente.
- [ ] Crear un script que detecte cuando haya una ventana maximizada en [hyprland.nix](nixos/dotFiles/hyprland.nix) y pause automáticamente las notificaciones de [dunst.nix](nixos/dotFiles/dunst.nix). También debe reactivar las notificaciones cuando no haya alguna ventana maximizada.



# Tareas completas
- [x] Se agrega condición a [volumen.sh](scripts/volumen.sh) para evitar subirlo a más del 100%.
- [x] Se modulariza el canal inestable usado en [inestables.nix](nixos/inestables.nix), de tal forma que no es necesario añadirlo con 'nix-channel -add'.
- [x] Home Manager ahora se instala de forma modular, por lo que no es necesario agregarlo como canal con 'nix-channel --add'.
- [x] Se elimina la sección que agrega el canal inestable y home manager en el script [instalar.sh](scripts/instalar.sh) ya que ahora ambos se añaden de forma modular. De todas formas se incluye la opción de que 'nixos' siga el canal estable, inestable o mantener el canal actual para los paquetes en [paquetes.nix](nixos/paquetes.nix).
- [x] Se eliminan varios scripts obsoletos.

Para ver todos los cambios, ir a [CHANGELOG.md](CHANGELOG.md)