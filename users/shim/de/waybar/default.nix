{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 28;
        spacing = 2;

        # Left modules
        modules-left = [
          "hyprland/workspaces"
          "hyprland/mode"
          "wlr/scratchpad"
        ];

        # Center modules
        modules-center = [ "hyprland/window" ];

        # Right modules
        modules-right = [
          "idle_inhibitor"
          "wireplumber"
          "network"
          "cpu"
          "memory"
          "temperature"
          "clock"
          "tray"
          "custom/power"
        ];

        # Module configurations
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{icon}";
          format-icons = {
            "1" = "󰲠";
            "2" = "󰲢";
            "3" = "󰲤";
            "4" = "󰲦";
            "5" = "󰲨";
            "6" = "󰲪";
            "7" = "󰲬";
            "8" = "󰲮";
            "9" = "󰲰";
            "10" = "󰿬";
            urgent = "󰀪";
            focused = "󰮯";
            default = "󰧞";
          };
        };

        "hyprland/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };

        "wlr/scratchpad" = {
          format = "{icon} {count}";
          show-empty = false;
          format-icons = [
            "󰏃"
            "󰏀"
          ];
          tooltip = true;
          tooltip-format = "{app}: {title}";
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          separate-outputs = true;
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };

        tray = {
          spacing = 10;
        };

        clock = {
          timezone = "America/Chicago";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = " {:%H:%M}";
          format-alt = " {:%Y-%m-%d}";
        };

        cpu = {
          format = "󰘚 {usage}%";
          tooltip = false;
          on-click = "pypr toggle taskman";
        };

        memory = {
          format = "󰍛 {}%";
          on-click = "pypr toggle taskman";
        };

        temperature = {
          thermal-zone = 2;
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format-critical = "󰸁 {temperatureC}°C";
          format = "󰔏 {temperatureC}°C";
        };

        network = {
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀 {ipaddr}/{cidr}";
          tooltip-format = "󰈀 {ifname} via {gwaddr}";
          format-linked = "󰈀 {ifname} (No IP)";
          format-disconnected = "󰈂 Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 {format_source}";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋎";
            phone = "󰏲";
            portable = "󰦢";
            car = "󰄋";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "pwvucontrol";
          scroll-step = 5;
        };

        "custom/power" = {
          format = "󰐥";
          tooltip = false;
          on-click = "~/.config/waybar/power-menu.sh";
        };
      };
    };
    style = with config.lib.stylix.colors.withHashtag; ''
      @define-color base00 ${base00}; @define-color base01 ${base01};
      @define-color base02 ${base02}; @define-color base03 ${base03};
      @define-color base04 ${base04}; @define-color base05 ${base05};
      @define-color base06 ${base06}; @define-color base07 ${base07};
      @define-color base08 ${base08}; @define-color base09 ${base09};
      @define-color base0A ${base0A}; @define-color base0B ${base0B};
      @define-color base0C ${base0C}; @define-color base0D ${base0D};
      @define-color base0E ${base0E}; @define-color base0F ${base0F};

      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 11px;          /* smaller text */
        min-height: 0;
      }

      window#waybar {
        background-color: alpha(@base00, 0.55);  /* more transparent */
        border-bottom: 1px solid alpha(@base03, 0.35);  /* thinner border */
        color: @base05;
        transition-property: background-color;
        transition-duration: .2s;
      }

      window#waybar.hidden { opacity: 0.15; }

      button {
        box-shadow: inset 0 -2px transparent;  /* thinner hover underline */
        border: none;
        border-radius: 0;
      }

      button:hover {
        background: alpha(@base00, 0.12);
        box-shadow: inset 0 -2px @base05;
      }

      #workspaces button {
        padding: 0 4px;           /* tighter */
        background-color: transparent;
        color: @base05;
      }
      #workspaces button:hover { background: alpha(@base00, 0.15); }
      #workspaces button.focused {
        background-color: alpha(@base03, 0.6);
        box-shadow: inset 0 -2px @base05;
      }
      #workspaces button.urgent { background-color: @base08; }

      #mode {
        background-color: alpha(@base03, 0.6);
        border-bottom: 1px solid alpha(@base05, 0.6);
      }

      /* tighter horizontal padding for all modules */
      #clock,#cpu,#memory,#disk,#temperature,#backlight,#network,#wireplumber,
      #custom-media,#tray,#mode,#idle_inhibitor,#scratchpad,#mpd,#custom-power {
        padding: 0 6px;           /* was 10px */
        color: @base05;
      }

      #window, #workspaces { margin: 0 3px; }
      .modules-left > widget:first-child > #workspaces { margin-left: 0; }
      .modules-right > widget:last-child > #workspaces { margin-right: 0; }

      #clock { background-color: alpha(@base03, 0.45); }
      label:focus { background-color: @base00; }

      #cpu         { background-color: alpha(@base0B, 0.25); color: @base05; }
      #memory      { background-color: alpha(@base0E, 0.25); color: @base05; }
      #disk        { background-color: alpha(@base09, 0.25); color: @base05; }
      #backlight   { background-color: alpha(@base0C, 0.25); color: @base05; }
      #network     { background-color: alpha(@base0D, 0.25); color: @base05; }
      #network.disconnected { background-color: alpha(@base08, 0.45); color: @base05; }
      #wireplumber { background-color: alpha(@base0A, 0.25); color: @base05; }
      #wireplumber.muted { background-color: alpha(@base01, 0.8); color: @base03; }
      #temperature { background-color: alpha(@base09, 0.25); color: @base05; }
      #temperature.critical { background-color: alpha(@base08, 0.5); color: @base05; }
      #tray        { background-color: alpha(@base0D, 0.25); color: @base05; }
      #idle_inhibitor { background-color: alpha(@base01, 0.7); color: @base05; }
      #idle_inhibitor.activated { background-color: alpha(@base0B, 0.35); color: @base05; }
      #scratchpad  { background-color: alpha(@base0B, 0.25); color: @base05; }
      #scratchpad.empty { background-color: transparent; }
      #custom-power { background-color: alpha(@base08, 0.85); color: @base00; }
      #custom-power:hover { background-color: alpha(@base08, 0.7); }
    '';

  };

  # Power menu script
  home.file.".config/waybar/power-menu.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Power menu options
      options="󰐥 Power Off\n󰜉 Restart\n󰋊 Hibernate\n󰍃 Logout\n󰌾 Lock"

      # Show menu with wofi
      chosen=$(echo -e "$options" | wofi --dmenu \
      	--prompt "Power Menu" \
      	--width 300 \
      	--height 250 \
      	--cache-file /dev/null \
      	--hide-scroll \
      	--no-actions)

      # Execute chosen action
      case $chosen in
      	"󰐥 Power Off")
      		systemctl poweroff
      		;;
      	"󰜉 Restart")
      		systemctl reboot
      		;;
      	"󰋊 Hibernate")
      		systemctl hibernate
      		;;
      	"󰍃 Logout")
      		hyprctl dispatch exit
      		;;
      	"󰌾 Lock")
      		loginctl lock-session
      		;;
      esac
    '';
    executable = true;
  };
}
