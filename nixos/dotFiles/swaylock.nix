{ config, pkgs, lib, ... }:

{

home.file = {


	".config/swaylock/config".text = ''
daemonize
show-failed-attempts
clock
effect-blur=9x9
effect-vignette=0.5:0.5
color=1f1d2e70
font="Lucida Grande"
indicator
indicator-radius=200
indicator-thickness=20
line-color=1f1d2e
ring-color=33CCFE
inside-color=1f1d2e
key-hl-color=EC4899
separator-color=00000000
text-color=e0def4
text-caps-lock-color=""
line-ver-color=eb6f92
ring-ver-color=eb6f92
inside-ver-color=1f1d2e
text-ver-color=e0def4
ring-wrong-color=31748f
text-wrong-color=31748f
inside-wrong-color=1f1d2e
inside-clear-color=1f1d2e
text-clear-color=e0def4
ring-clear-color=9ccfd8
line-clear-color=1f1d2e
line-wrong-color=1f1d2e
bs-hl-color=31748f
grace=2
grace-no-mouse
grace-no-touch
datestr=%Y-%m-%d
timestr=%H:%M:%S
fade-in=0.1
ignore-empty-password
	'';
};


	# Esto aún no funciona
	#programs.swaylock = {
	#	enable = true;
	#	settings = {
	#		daemonize = true;
	#		show-failed-attempts = true;
	#		clock = true;
	#		screenshot = true;
	#		effect-blur="9x9";
	#		effect-vignette="0.5:0.5";
	#		color="1f1d2e80";
	#		font="Lucida Grande";
	#		indicator = true;
	#		indicator-radius=200;
	#		indicator-thickness=20;
	#		line-color="1f1d2e";
	#		ring-color="33CCFE";
	#		inside-color="1f1d2e";
	#		key-hl-color="EC4899";
	#		separator-color="00000000";
	#		text-color="e0def4";
	#		text-caps-lock-color="";
	#		line-ver-color="eb6f92";
	#		ring-ver-color="eb6f92";
	#		inside-ver-color="1f1d2e";
	#		text-ver-color="e0def4";
	#		ring-wrong-color="31748f";
	#		text-wrong-color="31748f";
	#		inside-wrong-color="1f1d2e";
	#		inside-clear-color="1f1d2e";
	#		text-clear-color="e0def4";
	#		ring-clear-color="9ccfd8";
	#		line-clear-color="1f1d2e";
	#		line-wrong-color="1f1d2e";
	#		bs-hl-color="31748f";
	#		grace=2;
	#		grace-no-mouse = true;
	#		grace-no-touch = true;
	#		datestr="%Y-%m-%d";
	#		timestr="%H:%M:%S";
	#		fade-in=0.1;
	#		ignore-empty-password=true;

	#	};
	#};
}
