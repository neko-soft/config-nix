# Configs de NixOS Personal

En este repo se encuentra la configuración de mi sistema NixOS personal.



# Tareas Pendientes

- [ ] Arreglar [README.md](README.md), explicando todo con más detalle, especialmente los [scripts](scripts/). También incluir los atajos de teclado que se usan en [hyprland.nix](nixos/dotFiles/hyprland.nix).
- [ ] Ordenar bien las fuentes en los archivos [paquetes.nix](nixos/paquetes.nix) y [homeManager.nix](nixos/homeManager.nix).
- [ ] Agregar todas las configuraciones de [glava](glava/) a [glava.nix](nixos/dotFiles/glava.nix).
- [ ] Modularizar todo con `flakes`.
- [ ] Crear un script que cambie de fondo de pantalla, y según este, cambie los colores de [hyprland.nix](nixos/dotFiles/hyprland.nix), [waybar](nixos/dotFiles/waybar.nix), [dunst](nixos/dotFiles/dunst.nix), [glava](nixos/dotFiles/glava.nix), [cava](nixos/dotFiles/cava.nix), [kitty](nixos/dotFiles/kitty.nix), [rofi](nixos/dotFiles/rofi.nix) y [swaylock](nixos/dotFiles/swaylock.nix).
- [ ] Agregar en el script [instalar.sh](scripts/instalar.sh) la opción para descargar automáticamente los fondos de pantallas de Google Drive.
- [ ] Mejorar script [instalar.sh](scripts/instalar.sh) para que detecte los canales utilizados actuales, así evitar sobreescribirlos.
- [ ] Reordenar archivos de configuración `.nix` para que exista mayor consistencia con los nombres y sus contenidos.
- [ ] Configurar virtualización para VM con Win11.
- [ ] Crear un script para generar notificaciones en [dunst](nixos/dotFiles/dunst.nix) que muestren alertas de batería baja y temperatura alta en CPU.


# Últimos Cambios
- Se reordenan los [dotFiles](nixos/dotFiles) de [glava.nix](nixos/dotFiles/glava/glava.nix) de tal forma que queden agrupados en la subcarpeta [nixos/dotFiles/glava](nixos/dotFiles/glava/).
  
Para ver todos los cambios, ir a [CHANGELOG.md](CHANGELOG.md)