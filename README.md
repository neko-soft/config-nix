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
- [ ] Agregar condición a [volumen.sh](scripts/volumen.sh) para evitar subir el volumen a más del 100%.
- [ ] Agregar icon trays a [waybar.nix](nixos/dotFiles/waybar.nix).



# Tareas completas
- [x] Ajuste de tiempo de espera antes de cambiar velocidad de ventiladores. Antes era 5 segundos, ahora 15 segundos.
- [x] Se corrige [instalar.sh](scripts/instalar.sh) para que siempre instale el canal inestable, independiente de que si el usuario elige el canal estable o no.

Para ver todos los cambios, ir a [CHANGELOG.md](CHANGELOG.md)