{ config, pkgs, lib, ... }:

{

home.file = {

   ".config/glava/util/premultiply.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/util/premultiply.frag; };
   ".config/glava/util/smooth_pass.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/util/smooth_pass.frag; };
   ".config/glava/util/smooth.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/util/smooth.glsl; };
   ".config/glava/radial/1.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/radial/1.frag; };
   ".config/glava/radial/2.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/radial/2.frag; };
   ".config/glava/bars/1.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/bars/1.frag; };
   ".config/glava/env_KWin.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/env_KWin.glsl; };
   ".config/glava/env_i3.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/env_i3.glsl; };
   ".config/glava/env_Openbox.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/env_Openbox.glsl; };
   ".config/glava/graph.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/graph.glsl; };
   ".config/glava/env_awesome.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/env_awesome.glsl; };
   ".config/glava/rc.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/rc.glsl; };
   ".config/glava/bars.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/bars.glsl; };
   ".config/glava/wave.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/wave.glsl; };
   ".config/glava/wave/1.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/wave/1.frag; };
   ".config/glava/wave/2.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/wave/2.frag; };
   ".config/glava/smooth_parameters.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/smooth_parameters.glsl; };
   ".config/glava/radial.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/radial.glsl; };
   ".config/glava/graph/1.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/graph/1.frag; };
   ".config/glava/graph/2.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/graph/2.frag; };
   ".config/glava/graph/3.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/graph/3.frag; };
   ".config/glava/env_Xfwm4.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/env_Xfwm4.glsl; };
   ".config/glava/circle/1.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/circle/1.frag; };
   ".config/glava/circle/2.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/circle/2.frag; };
   ".config/glava/circle/3.frag" = { text = builtins.readFile /home/nekonix/config-nix/glava/circle/3.frag; };
   ".config/glava/env_default.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/env_default.glsl; };
   ".config/glava/circle.glsl" = { text = builtins.readFile /home/nekonix/config-nix/glava/circle.glsl; };

};

}
