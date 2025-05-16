{ config, pkgs, lib, ... }:

{

programs.waybar = {

  enable = true;
  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      margin-bottom = 0;
      modules-left = [ "clock" "hyprland/workspaces"];
      modules-center = [ "hyprland/window"];
      modules-right = [ "network" "temperature" "memory" "cpu"
                      "pulseaudio" "cava" "battery"];

      "hyprland/window" = {
        format = "{title}";
        separate-outputs = false;
	icon = false;
	icon-size = 24;
	rewrite = {
		"(.*) — Mozilla Firefox" = " $1 - Mozilla Firefox";
		"nekonix@nixos: (.*)" = "  nekonix@nixos: $1";
		"(.*) - thunar" = "  $1 - Thunar";
		"(.*) - Visual Studio Code" = "󰨞 $1 - Visual Studio Code";

	};
      };
      "hyprland/submap" = {
        format = "✌️✌️ {}";
        max-length = 8;
        tooltip = true;
      };

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
          "6" = "6";
          "7" = "7";
          "8" = "8";
          "9" = "9";
          "10" = "10";
          "-99" = "-99";
          "active"= "";
          "default"= "";
        };

      };
      network = {
          #interface = "enp9s0f4u2";
          #tooltip-format-ethernet = "{ifname} ";
          interval = 1;
          format = "{bandwidthDownBytes}  {bandwidthUpBytes} ";
      };

      battery = {
        interval = 1;
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% {icon}󱐋";
        format-full = "{capacity}% {icon}󱐋";
        format-icons = [ "󱃍" "󰁻" "󰁾" "󰂀" "󰁹"];
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

      "custom/powermenu" = {
        format = "";
        tooltip = false;
        on-click = "exec wlogout -p layer-shell";
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
            font-family: "Hack Nerd Font", "Symbols Nerd Font", "Font Awesome 6 Free", sans-serif;
          }

          #waybar .module {
          font-family: "Hack Nerd Font", "Symbols Nerd Font", "Font Awesome 6 Free", sans-serif;
          }

          #workspaces button {
            color: #c3aeff;
          }
          /* Fix: active workspace doesn't show up */
          /* #workspaces button.focused { */
          #workspaces button.active {
            color: #c3aeff;
          }

          #custom-powermenu,
          #cpu,
          #temperature,
          #memory,
          #workspaces,
          #clock,
          #window,
          #battery,
          #pulseaudio,
          #cava,
          #network {
            padding: 4px 8px;
            background-color: rgba(0,0,0,0.8);
            /*background-color: #303643;*/
            border-radius: 30px;
            margin: 6px 2px;
          }

	  #cpu,
	  #memory,
	  #temperature,
	  #network,
	  #battery,
	  #pulseaudio,
	  #cava {
  	  min-width: 0px;  /* o lo que se vea bien */
	  }
	  #battery {
	  min-width: 60px;
	  }


          #window {
            color: #929db1;
          }

          #battery {
          color: #859900;
          }

          #tray {
            margin-left: 4px;
          }

          #custom-updates {
            color: #1788e4;
          }

          #custom-powermenu {
            color: #e06c75;
            padding-right: 11px;
            margin-right: 8px;
          }

          #scratchpad {
            color: #cffafe;
            padding-right: 4px;
            padding-left: 4px;
          }



          #pulseaudio,
          #cava {
            color: #0fb9b1; 
            background-color: rgba(0,0,0,0.5);
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

        '';




};

}
