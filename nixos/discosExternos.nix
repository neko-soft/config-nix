{lib, config, pkgs, ... }:
{
	fileSystems."/home/nekonix/discosExternos/disco1TB" = {
		device = "UUID=6A9E-6491";
		fsType = "exfat";
		options = ["nofail" "users" "rw"] ;
	};

	fileSystems."/home/nekonix/discosExternos/discoSecundario" = {
		device = "UUID=9C3B-632F";
		fsType = "exfat";
		options = ["nofail" "users" "rw"] ;
	};


}
