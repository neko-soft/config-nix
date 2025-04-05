{lib, config, pkgs, ... }:
{
	fileSystems."/mnt/nas" = {
		device = "/dev/disk/by-uuid/10c6d2e9-910d-4aa6-96a8-a65ceb637255";
		fsType = "ext4";
		options = ["defaults"];
	};

	services.samba = {
		enable = true;
		openFirewall = true;
		settings = {
			global = {
				workgroup = "WORKGROUP";
				security = "user";
				"map to guest" = "Never";
				"passdb backend" = "tdbsam";
			};
			shared = {
				comment = "NAS Storage";
				path = "/mnt/nas";
				browseable = "yes";
				"read only" = "no";
				"guest ok" = "no";
				"valid users" = "nasuser";
			};
		};
	};

	users.users.nasuser = {
		isSystemUser = true;
		home = "/mnt/nas";
		createHome = false;
		group = "nasgroup";
	};

	users.groups.nasgroup = {};

}
