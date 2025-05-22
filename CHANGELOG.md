# 2025-05-21

- [refresco.sh](scripts/refresco.sh) quedó obsoleto ya que ahora todos los dotFiles se manejan con [homeManager.nix](nixos/homeManager.nix).
- Se elimina `cachix` de [paquetes.nix](nixos/paquetes.nix) al no ser necesario una vez configurando los `substituters` y `trusted-public-keys` en el mismo archivo.
- [agregarCanales.sh](scripts/agregarCanales.sh) quedó obsoleto. Se incorpora todo dentro del nuevo archivo [instalar.sh](scripts/instalar.sh)
- Se añade el script [instalar.sh](scripts/instalar.sh) que copia los archivos del repo al sistema, haciendo todos los cambios necesarios para poder reconstruir NixOS.
- Se elimina [cachix.nix](nixos/cachix.nix) y la carpeta [cachix](nixos/cachix/) al ser incorporados directamente en [paquetes.nix](nixos/paquetes.nix).
- [nixos/respaldo/](nixos/respaldo/) es añadido al `.gitignore`.
- 