{ config, pkgs, lib, ... }:

{

home.file = {

   ".config/glava/awesome.glsl".text = ''
#request setxwintype "!-"
   '';

   ".config/glava/env_default.glsl".text = ''
#request setxwintype "desktop"
   '';

   ".config/glava/env_i3.glsl".text = ''
#request setxwintype "!-"
   '';

   ".config/glava/env_KWin.glsl".text = ''
#request setdecorated false
#request setxwintype "normal"
#request addxwinstate "below"
#request addxwinstate "skip_taskbar"
#request addxwinstate "skip_pager"
#request addxwinstate "pinned"
#request setclickthrough true
   '';

   ".config/glava/env_Openbox.glsl".text = ''
#request setxwintype "desktop"
#request addxwinstate "pinned"
   '';

   ".config/glava/env_Xfwm4.glsl".text = ''
#request setxwintype "desktop"
#request addxwinstate "pinned"
#request addxwinstate "below"
   '';

};

}