# Este módulo tiene todo sobre el network y el host y usuario y cosas
{ lib, config, pkgs, ... }:


{ 

	networking.hostName = "nixos"; # Define your hostname.
	#networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;



	boot.extraModulePackages = [ config.boot.kernelPackages.r8168];
 	boot.blacklistedKernelModules = [ "r8169" ];
	  boot.kernel.sysctl = {
    		"net.core.default_qdisc" = "fq";
   		"net.ipv4.tcp_congestion_control" = "bbr";
  	  	"net.ipv4.tcp_fin_timeout" = 15;
  	  	"net.ipv4.tcp_tw_reuse" = 1;
  	  	"net.core.rmem_max" = 16777216;
  	  	"net.core.wmem_max" = 16777216;
   	 	"net.ipv4.tcp_rmem" = "4096 87380 16777216";
  	  	"net.ipv4.tcp_wmem" = "4096 65536 16777216";
 		"net.ipv4.ip_local_port_range" = "10240 65535"; # Rango de puertos disponibles más grande
 		"net.ipv4.tcp_syncookies" = 1; # Protege contra floods TCP
 		"net.ipv4.tcp_slow_start_after_idle" = 0; # No hacer slow-start al retomar conexiones
  	};
 
	# Aumentar límite de archivos abiertos
 		security.pam.loginLimits = [
   			{ domain = "*"; type = "hard"; item = "nofile"; value = "1048576"; }
   			{ domain = "*"; type = "soft"; item = "nofile"; value = "1048576"; }
 		];


	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.nekonix = {
		isNormalUser = true;
		description = "NekoNix";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
	};





}
