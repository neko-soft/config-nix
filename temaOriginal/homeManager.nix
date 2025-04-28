       # Config dunst
        ".config/dunst/dunstrc".text = ''
          [global]
            frame_color = "#88c0d0"
            separator_color = "frame"
            background = "#2e3440"
            foreground = "#eceff4"
        '';

        # CSS de Waybar
        ".config/waybar/style.css".text = ''
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
            font-family: "Hack Nerd Font";
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

        # Tema de Kitty

        ".config/kitty/current-theme.conf".text = ''
          # vim:ft=kitty

          ## name: Base2Tone Drawbridge Dark
          ## author: Bram de Haan (https://github.com/atelierbram)
          ## license: MIT
          ## upstream: https://github.com/atelierbram/Base2Tone-kitty/blob/main/themes/base2tone-drawbridge-dark.conf
          ## blurb: Duotone theme | bright blue - bright turquoise


          #: The basic colors

          foreground #cbceda
          background #1b1f32
          background_opacity 0.9
          selection_foreground #9094a7
          selection_background #252a41


          #: Cursor colors

          cursor #289dbd
          cursor_text_color #1b1f32


          #: URL underline color when hovering with mouse

          url_color #c3cdfe


          #: kitty window border colors and terminal bell colors

          active_border_color #444b6f
          inactive_border_color #1b1f32
          bell_border_color #4961da
          visual_bell_color none


          #: OS Window titlebar colors

          wayland_titlebar_color #252a41
          macos_titlebar_color #252a41


          #: Tab bar colors

          active_tab_foreground #f9fbfb
          active_tab_background #1b1f32
          inactive_tab_foreground #a6aeb0
          inactive_tab_background #252a41
          tab_bar_background #252a41
          tab_bar_margin_color none


          #: Colors for marks (marked text in the terminal)

          mark1_foreground #1b1f32
          mark1_background #516aec
          mark2_foreground #1b1f32
          mark2_background #818b8d
          mark3_foreground #1b1f32
          mark3_background #33abcc


          #: The basic 16 colors

          #: black
          color0 #1b1f32
          color8 #51587b

          #: red
          color1 #627af4
          color9 #75d5f0

          #: green
          color2 #67c9e4
          color10 #252a41

          #: yellow
          color3 #99e9ff
          color11 #444b6f

          #: blue
          color4 #7289fd
          color12 #5e6587

          #: magenta
          color5 #67c9e4
          color13 #c3cdfe

          #: cyan
          color6 #8b9efd
          color14 #5cbcd6

          #: white
          color7 #9094a7
          color15 #e1e6ff

        '';

        # Config SwayLock
        ".config/swaylock/config".text = ''
          daemonize
          show-failed-attempts
          clock
          screenshot
          effect-blur=9x9
          effect-vignette=0.5:0.5
          color=1f1d2e80
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