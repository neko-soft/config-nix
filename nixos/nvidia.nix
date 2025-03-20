# Este módulo tiene weás relacionadas con NVIDIA y sus weás.


{ lib, config, pkgs, ... }:


{ 


 # Enable OpenGL

  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
    cudaPackages.cudnn
    cudaPackages.cuda_cccl
    cudaPackages.cuda_nvcc
  ];


  hardware.graphics.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    prime = {
            offload = {
			    enable = false;
			    enableOffloadCmd = false;
	    	};
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
    };
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;


  };




}
