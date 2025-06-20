# Este módulo tiene todo sobre el locale, el tiempo, el lenguaje, etcétera
{ lib, config, pkgs, ... }:


{ 

	# Set your time zone.
	time.timeZone = "America/Santiago";

	# Select internationalisation properties.
	#i18n.defaultLocale = "en_US.UTF-8";
	i18n.defaultLocale = "es_CL.UTF-8";

	i18n.extraLocaleSettings = {
	LC_ADDRESS = "es_CL.UTF-8";
	LC_IDENTIFICATION = "es_CL.UTF-8";
	LC_MEASUREMENT = "es_CL.UTF-8";
	LC_MONETARY = "es_CL.UTF-8";
	LC_NAME = "es_CL.UTF-8";
	LC_NUMERIC = "es_CL.UTF-8";
	LC_PAPER = "es_CL.UTF-8";
	LC_TELEPHONE = "es_CL.UTF-8";
	LC_TIME = "es_CL.UTF-8";
	};



	# Configure console keymap
	console.keyMap = "la-latin1";

	# Este es para que no se desincronice el tiempo cuando está con dualBoot con Windows
	time.hardwareClockInLocalTime = true;




}
