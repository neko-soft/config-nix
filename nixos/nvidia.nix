# Este módulo tiene weás relacionadas con NVIDIA y sus weás.


{ lib, config, pkgs, ... }:


{ 

 # Enable OpenGL
  hardware.graphics.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    prime = {
            offload = {
			    enable = true;
			    enableOffloadCmd = true;
	    	};
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
    };
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;


  };




}
