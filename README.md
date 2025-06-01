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
- [x] Se crea el script [ventiladores.sh](scripts/ventiladores.sh). Este script controla la velocidad de los ventiladores según al temperatura de la CPU. Este script sólo funciona en laptops OMEN de HP y es muy importante que NO se utlice en otras laptops o dispositivos. Si bien existe un chequeo que verifica el nombre del dispositivo para asegurarse de que sea un OMEN, lo ideal es eliminar el script o comentar su ejecución en [hyprland.nix](nixos/dotFiles/hyprland.nix).

  
Para ver todos los cambios, ir a [CHANGELOG.md](CHANGELOG.md)