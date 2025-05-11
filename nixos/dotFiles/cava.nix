{ config, pkgs, lib, ... }:

{

home.file = {
  ".config/cava/config".text = ''
[general]
bars = 0
bar_width = 1
	'';
};
}
