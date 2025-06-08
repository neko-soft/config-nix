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


# Tareas completas
- [x] Se agrega script para silenciar notificaciones [pausarNotificaciones.sh](scripts/pausarNotificaciones.sh).
- [x] Se crea el script [bloqueoPantalla.sh](scripts/bloqueoPantalla.sh) que apaga las notificaciones, y muestra el fondo de pantalla antes de bloquear el sistema.
- [x] Se crea el scripts [menuRofi.sh](scripts/menuRofi.sh) en donde se muestran distintas opciones y acciones que el usuario puede realizar. De momento está la opción de silenciar todas las notificaciones excepto las urgentes, y elegir un fondo de pantalla animado.

Para ver todos los cambios, ir a [CHANGELOG.md](CHANGELOG.md)