{ config, pkgs, lib, ... }:

{


services.dunst = {
	enable = true;
	
	settings = {
		global = {
			origin = "top-right";
			offset = "2x2";
			width = "(0,500)";
			height = "(0,300)";
			font = "Monospace 12";
			min_icon_size = 50;
			max_icon_size = 100;
			corner_radius = 10;
			frame_color = "#5cbcd6";
			separator_color = "frame";
			background = "#1b1f32e6";
			foreground = "#5cbcd6";
		};
	};
};



}
