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
      modules-center = [ "hyprland/window" ];
      modules-right = [ "network" "temperature" "memory" "cpu"
                      "pulseaudio" "battery"];

      "hyprland/window" = {
        format = "{}";
        separate-outputs = false;
      };
      "hyprland/submap" = {
        format = "✌️ {}";
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
          format = "{bandwidthDownBytes}  {bandwidthUpBytes}  ";
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
        format-critical = "{temperatureC}°C ";
        format = "{temperatureC}°C ";
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
        format-muted = "";
        format-icons = {
          headphone = "";
          "hands-free" = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" ];
        };
        scroll-step = 1;
        on-click = "pavucontrol";
      };

      clock = {
        format = "{:%F  %R}  ";
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
            padding: 0 5px;
            color: #c3aeff;
          }
          /* Fix: active workspace doesn't show up */
          /* #workspaces button.focused { */
          #workspaces button.active {
            color: #c3aeff;;
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
          #network {
            padding: 4px 8px;
            background-color: rgba(0,0,0,0.5);
            /*background-color: #303643;*/
            border-radius: 30px;
            margin: 6px 4px;
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

          #pulseaudio {
            color: #0fb9b1;
            padding-right: 14px;
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
            margin-left: 8px;
            /* opacity: 0.7; */
            /* font-size: 18px; */
          }

        '';




};

}
