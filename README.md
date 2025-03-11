# Configs de NixOS Personal

La idea de este repo es poner los archivos config de mi sistema con NixOS.

También hay unos scrips que automatizan ciertos procesos.

# Pendientes

## Documentación
- [ ] Explicar bien cómo funciona todo esto.
- [ ] Ordenar mejor el [README.md](README.md). Agregar imágenes y emojis para que no sea una masa de texto que dan ganas de vomitar con sólo mirarla.

## Script [refresco.sh](refresco.sh)
- [ ] Verificar primero si hay cambios en los archivos de hyprland, hyprpaper y waybar antes de ejecutar los comandos, para evitar recargas innecesarias.

## Script [actualizar.sh](actualizar.sh)
- [ ] Este script antes funcionaba con los archivos .config, pero ahora se maneja todo desde el Home-Manager, así que hay varias cosas rebundantes.
- [ ] Asegurarse de mantener la linea `boot.initrd.luks.devices` igual que está en el archivo original antes de reemplazar todo el resto.
- [ ] Cambiar todos los archivos que tengan paths o referencias hacia el nombre de usuario por el nombre del usuario actual, porque ahora está todo con `nekonix`. Hasta donde se sabe, hay que cambiar estos archivos:
    - [ ] [homeManager.nix](nixos/homeManager.nix)
    - [ ] [servicios.nix](nixos/servicios.nix)

## Wallpapers
- [ ] Hacer un script que permita cambiar el fondo de pantalla automáticamente de hyprland y/o GRUB. Esto tiene que hacerse cambiando las configuraciones de los archivos [homeManager.nix](nixos/homeManager.nix) (en la sección de `".config/hypr/hyprpaper.conf".text = ''`) y [bootLoader.nix](nixos/bootLoader.nix). Creo -pero no estoy seguro- que GRUB sólo admite formatos `.png`, así que el script debería ser capaz de convertir otros formatos a `.png`.

## Colores según Wallpaper
- [ ] Hacer un script que cambie los colores de estilo y temas de kitty, hyprland, waybar, rofi, swaylock y GRUB según los colores del fondo de pantalla. Esto puede hacerse con un script que analice los colores de la imagen del wallpaper, y modificar los archivos `.nix` correspondientes (principalmente [homeManager.nix](nixos/homeManager.nix)y [servicios.nix](nixos/servicios.nix)) para que todo tenga una armonía de colores.


