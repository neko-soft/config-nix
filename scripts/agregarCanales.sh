#!/usr/bin/env bash

sudo nix-channel --add https://nixos.org/channels/nixos-25.05 nixos
sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager

sudo nix-channel --update

# Antes de rebuild hay que comentar cachix y homeManager
# También cambiar el disco que hay en el configuration.nix original
# Mantener la versión que venía en configuration.nix original
sudo nixos-rebuild switch

sudo cachix use nix-community

# Descomentar cachix y homeManager
sudo nixos-rebuild switch
