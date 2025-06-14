# Configs de NixOS Personal

En este repo se encuentra la configuración de mi sistema NixOS personal.



# Tareas pendientes

- [ ] Arreglar [README.md](README.md), explicando todo con más detalle, especialmente los [scripts](scripts/). También incluir los atajos de teclado que se usan en [hyprland.nix](nixos/dotFiles/hyprland.nix).
- [ ] Ordenar bien las fuentes en los archivos [paquetes.nix](nixos/paquetes.nix) y [homeManager.nix](nixos/homeManager.nix).
- [ ] Modularizar todo con `flakes`.
- [ ] Crear un script que cambie de fondo de pantalla, y según este, cambie los colores de [hyprland.nix](nixos/dotFiles/hyprland.nix), [waybar](nixos/dotFiles/waybar.nix), [dunst](nixos/dotFiles/dunst.nix), [glava](nixos/dotFiles/glava.nix), [cava](nixos/dotFiles/cava.nix), [kitty](nixos/dotFiles/kitty.nix), [rofi](nixos/dotFiles/rofi.nix) y [swaylock](nixos/dotFiles/swaylock.nix).
- [ ] Agregar en el script [instalar.sh](scripts/instalar.sh) la opción para descargar automáticamente los fondos de pantallas de Google Drive.
- [ ] Reordenar archivos de configuración `.nix` para que exista mayor consistencia con los nombres y sus contenidos.
- [ ] Configurar virtualización para VM con Win11.
- [ ] Agregar sonidos a las notificaciones, especialmente a las que son urgentes.
- [ ] Crear un script detecte inactividad.


# Tareas completas
- [x] Se agrega al [menuRofi.sh](scripts/menuRofi.sh) una opción para recargar hyprland, hyprpaper, waybar y dunst.
- [x] Se elimina la notificación de temperatura entre 80°C y 90°C, en [temperaturaCpu.sh](scripts/temperaturaCpu.sh), dejando sólo la notificación de alerta sobre los 90°C.
 
Para ver todos los cambios, ir a [CHANGELOG.md](CHANGELOG.md)