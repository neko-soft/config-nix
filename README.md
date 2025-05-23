# Configs de NixOS Personal

En este repo se encuentra la configuración de mi sistema NixOS personal.



# Tareas Pendientes

- [ ] Arreglar [README.md](README.md), explicando todo con más detalle, especialmente los [scripts](scripts/). También incluir los atajos de teclado que se usan en [hyprland.nix](nixos/dotFiles/hyprland.nix).
- [ ] Ordenar bien las fuentes en los archivos [paquetes.nix](nixos/paquetes.nix) y [homeManager.nix](nixos/homeManager.nix).
- [ ] Agregar todas las configuraciones de [glava](glava/) a [glava.nix](nixos/dotFiles/glava.nix).
- [ ] Modularizar todo con `flakes`.
- [ ] Crear un script que cambie de fondo de pantalla, y según este, cambie los colores de [hyprland.nix](nixos/dotFiles/hyprland.nix), [waybar](nixos/dotFiles/waybar.nix), [dunst](nixos/dotFiles/dunst.nix), [glava](nixos/dotFiles/glava.nix), [cava](nixos/dotFiles/cava.nix), [kitty](nixos/dotFiles/kitty.nix), [rofi](nixos/dotFiles/rofi.nix) y [swaylock](nixos/dotFiles/swaylock.nix).
- [x] ~~Configurar las excepciones del firewall en [networkAndHost.nix](nixos/networkAndHost.nix).~~
- [ ] Agregar en el script [instalar.sh](scripts/instalar.sh) la opción para descargar automáticamente los fondos de pantallas de Google Drive.
- [ ] Reordenar archivos de configuración `.nix` para que exista mayor consistencia con los nombres y sus contenidos.


# Últimos Cambios
- Se reordenan las tareas pendientes y la estructura del [README.md](README.md).
- Fueron eliminados paquetes y servicios no utilizados, como `MySQL`, `Open Tablet Driver` y `OpenRGB`.
- La configuración [networkAndHost.nix](nixos/networkAndHost.nix) fue reordenada, y se bloquean los pings en IPv4.
  
Para ver todos los cambios, ir a [CHANGELOG.md](CHANGELOG.md)