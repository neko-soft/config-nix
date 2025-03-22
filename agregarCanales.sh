sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager

sudo cachix use nix-community
sudo nix-channel --update
sudo nixos-rebuild switch
