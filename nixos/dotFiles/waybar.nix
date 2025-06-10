{ config, pkgs, lib, ... }:

{

programs.waybar = {

  enable = true;
  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      margin-bottom = 0;
      modules-left = [ "clock" "custom/weather" "hyprland/workspaces" "hyprland/window" ];
      modules-center = [ ];
      modules-right = [ "network" "temperature" "memory" "cpu"
                      "pulseaudio" "cava" "custom/spotify" "battery"];



      "hyprland/window" = {
        format = "{title}";
        separate-outputs = true;
	icon = false;
	icon-size = 24;
	rewrite = {
		"(.*) — Mozilla Firefox" = " Firefox - $1";
		"nekonix@nixos(.*)" = "󰄛 Kitty - nekonix@nixos$1";
		"(.*) - Thunar" = "  Thunar - $1";
		"(.*) - Visual Studio Code" = "󰨞 Visual Studio Code - $1";
		"qBittorrent (.*)" = "󰰜 qBittorrent $1";
		"Bottles" = "󰡔 Bottles $1";

	};
      };
      "hyprland/submap" = {
        format = "✌️✌️ {}";
        max-length = 8;
        tooltip = true;
      };

      "custom/spotify" = {
	format = {};
	exec = "~/config-nix/scripts/currentSongSpotify.sh";
	interval = 2;
	return-type = "json";
	on-click = "playerctl -p spotify play-pause";
      };


      "custom/weather" = {
	exec = "/home/nekonix/config-nix/scripts/weather.sh";
	return-type = "json";
	format = "{}";
	tooltip = true;
	interval = 3600;
      };

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "01";
	  "2" = "02";
          "3" = "03";
          "4" = "04";
          "5" = "05";
          "6" = "06";
          "7" = "07";
          "8" = "08";
          "9" = "09";
          "10" = "10";
          "11" = "11";
          "12" = "12";
          "13" = "13";
          "14" = "14";
          "15" = "15";
          "16" = "16";
          "17" = "17";
          "18" = "18";
          "19" = "19";
          "20" = "20";
          "-99" = "-99";
          "active"= "";
          "default"= "";
	  "spotify" = "";
	  "obsidian" = "󱞁";
	  "mail" = "";
        };
	#window-rewrite-default = "?";
	#window-rewrite = {
	#	"class<firefox>" = "󰈹 ";
	#	"class<kitty>" = " ";
	#	"class<Code>" = "󰨞 ";
	#	"class<spotify>" = " ";
	#};
	show-special = true;
	all-outputs = true;
      };
      network = {
          #interface = "enp9s0f4u2";
          #tooltip-format-ethernet = "{ifname} ";
          interval = 1;
          format = "{bandwidthDownBytes}  {bandwidthUpBytes} ";
          format-ethernet = "Ethernet  ";
          format-wifi = "WiFi {icon}{signalStrenght}%";
	  format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
	  format-disconnected = "Desconectado 󰤮 ";
          format-alt = "{bandwidthDownBytes}  {bandwidthUpBytes} ";
      };

      battery = {
        interval = 1;
        states = {
          good = 95;
          warning = 50;
          critical = 20;
        };
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% {icon}󱐋";
        format-full = "{capacity}% {icon}󱐋";
        
        format-critical = "{capacity}% {icon}";
        format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        max-length = 25;
      };

      temperature = {
        thermal-zone = 2;
        hwmon-path = [
          "/sys/class/hwmon/hwmon5/temp1_input"
          "/sys/class/hwmon/hwmon3/temp1_input"
          "/sys/class/hwmon/hwmon4/temp1_input"
          "/sys/class/hwmon/hwmon7/temp1_input"
          "/sys/class/thermal/thermal_zone0/temp"
        ];
        critical-threshold = 80;
        format-critical = "{temperatureC}°C   ";
        format = "{temperatureC}°C {icon}";
        format-icons = ["" "" "" ""];
	interval = 1;
      };


      memory = {
        format = "{used:0.1f}G/{total:0.1f}G  ";
        tooltip = false;
        interval = 1;
      };

      cpu = {
        format = "{usage}%  ";
        tooltip = true;
      };


      pulseaudio = {
        format = "{volume}% {icon}";
        format-bluetooth = "{volume}% {icon}";
        format-muted = "󰖁";
        format-icons = {
          headphone = " ";
          speaker = "󰓃";
          "hands-free" = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" ];
        };
        scroll-step = 1;
        on-click = "pavucontrol";
        max-volume = 100;
      };

      cava = {
        framerate = 144;
        autosens = 1;
        #sensitivity = 100;
        bars = 14;
        lower_cutoff_freq = 50;
        higher_cutoff_freq = 10000;
        sample_rate = 44100;
        sample_bits = 8;
        method = "pulse";
        source = "auto";
        sleep_timer = 10;
        hide_on_silence = true;
        stereo = true;
        reverse = false;
        bar_delimiter = 0;
        monstercat = false;
        waves = false;
        noise_reduction = 0.77;
        input_delay = 0;
        format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
        actions = {
          on-right-click = "mode";
        };
       };

      



      clock = {
        format = "{:%F   %R}  ";
        interval = 1;
      };

    };
  };
  style = ''

          * {
            border: none;
            border-radius: 0;
            min-height: 0;
            margin: 0;
            padding: 0;
          }
          #waybar {
            /* background: #1e222a; */
            
            background: rgba(27, 31, 50,0);
            color: #eeeeef;
            font-size: 14px;
            font-family: "Hack Nerd Font", "FiraCode Nerd Font", sans-serif;
          }


          #workspaces button {
            color: #c3aeff;
	    margin: 0 2px;
          }
          /* Fix: active workspace doesn't show up */
          /* #workspaces button.focused { */
          #workspaces button.active {
            color: #c3aeff;
          }

          #custom-menu,
          #cpu,
          #temperature,
          #memory,
          #workspaces,
          #clock,
          #window,
          #battery,
          #pulseaudio,
          #cava,
	  #custom-spotify,
	  #custom-weather,
	  #tray,
          #network {
            padding: 4px 8px;
            background-color: rgba(0,0,0,0.8);
            /*background-color: #303643;*/
            border-radius: 30px;
            margin: 6px 2px;
          }

	  #battery {
	  min-width: 60px;
	  color: #859900
	  }

          #window {
            color: #cacaca;
          }
	  #custom-weather {
		color: #fcd0f3
	  }


          #tray {
            margin-left: 4px;
          }


          #scratchpad {
            color: #cffafe;
            padding-right: 4px;
            padding-left: 4px;
          }


	  #custom-spotify,
          #pulseaudio,
          #cava {
            color: #0fb9b1; 
	  }

          


          #cpu {
            color: #61afef;
          }

          #temperature {
            color: #98c379;
          }

          #memory {
            color: #e5c07b;
          }

          #network {
            color: #c678dd;
            /*min-width: 200px;*/
          }

          #clock {
            color: #f7bfbf;
            /* opacity: 0.7; */
            /* font-size: 18px; */
          }
	  
	  window#waybar.empty #window {
		background-color: transparent;
	  }
        '';




};

}
