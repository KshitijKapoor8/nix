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

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 20;

      modules-left = [
        "custom/launcher"
        "idle_inhibitor"
        "mpris"
        "wireplumber"
        "custom/cava"
      ];

      modules-center = [
        "hyprland/workspaces"
        "clock"
        "wlr/taskbar"
      ];

      modules-right = [
        # "custom/bluetooth"   # (intentionally omitted)
        "network"
        "power-profiles-daemon"
        "cpu"
        "memory"
        "tray"
        "battery"
        "custom/swaync"
      ];

      # --- Safe placeholders for custom/* (no scripts yet) ---
      "custom/launcher" = {
        format = "🌪";
        tooltip = false;
      };
      "custom/cava" = {
        format = "▁▂▃▄▅▆▇█";
        tooltip = false;
      };
      "custom/swaync" = {
        format = "󰎟";
        tooltip = "Notification Center";
      };

      # --- Core modules (simple, working defaults) ---
      idle_inhibitor = {
        format = "{icon}";
        "format-icons" = {
          activated = "󰒳";
          deactivated = "󰒲";
        };
        tooltip = true;
      };

      mpris = {
        format = "{player_icon} {dynamic}";
        "format-paused" = "{status_icon} {dynamic}";
        "format-stopped" = "";
        "ignore-list" = [ "vesktop" ];
        "player-icons" = {
          default = "";
          spotify = "";
          vlc = "";
          mpv = "";
        };
        "status-icons" = {
          paused = "▶";
          playing = "⏸";
        };
        "max-length" = 40;
        tooltip = true;
      };

      wireplumber = {
        format = "{icon} {volume}%";
        "format-muted" = "";
        "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };

      "hyprland/workspaces".format = "{icon}";

      clock = {
        format = "{:%I:%M %p}";
        tooltip = false;
      };

      "wlr/taskbar" = {
        format = "{icon}";
        "icon-size" = 16;
        "on-click" = "activate";
        "on-click-middle" = "close";
        "ignore-list" = [
          "foot"
          "vesktop"
        ];
        markup = true;
        "all-outputs" = false;
      };

      network = {
        "format-wifi" = " {essid} {signalStrength}%";
        "format-ethernet" = "󰈀 {ifname}";
        "format-disconnected" = "󰖪";
        tooltip = false;
        interval = 2;
      };

      "power-profiles-daemon" = {
        format = "{icon} {profile}";
        "format-icons" = {
          performance = "󰓅";
          balanced = "󰾅";
          "power-saver" = "󰾆";
        };
      };

      cpu = {
        format = " {usage}%";
        states = {
          warning = 70;
          critical = 90;
        };
        tooltip = true;
      };

      memory = {
        format = " {used:0.1f}G/{total:0.1f}G";
        states = {
          warning = 75;
          critical = 90;
        };
        interval = 30;
      };

      battery = {
        format = "{icon} {capacity}%";
        "format-charging" = " {capacity}%";
        "format-plugged" = " {capacity}%";
        states = {
          warning = 30;
          critical = 15;
        };
      };

      tray.spacing = 6;
    };

    style = with config.lib.stylix.colors.withHashtag; ''
        /* ===== Stylix-driven palette (maps your names to base00..base0F) ===== */
        @define-color bg        ${base00};
        @define-color fg        ${base05};
        @define-color muted     ${base03};

        @define-color red       ${base08};
        @define-color orange    ${base09};
        @define-color yellow    ${base0A};
        @define-color green     ${base0B};
        @define-color aqua      ${base0C};
        @define-color blue      ${base0D};
        @define-color purple    ${base0E};

        /* “bright_*” map to the same base hues so they track the theme.
           If you want stronger contrast later, we can add alpha/lighten tweaks. */
        @define-color bright_red    ${base08};
        @define-color bright_green  ${base0B};
        @define-color bright_yellow ${base0A};
        @define-color bright_aqua   ${base0C};
        @define-color bright_blue   ${base0D};
        @define-color bright_purple ${base0E};

        /* ========================= BASE RESET ========================= */
        * {
          padding: 0;
          margin: 0;
          min-height: 0;
          border-radius: 0px;
          border: none;
          text-shadow: none;
          transition: none;
          box-shadow: none;
        }

        window#waybar {
          background: @bg;
          padding: 2px 0;
          font-family: "JetBrainsMono Nerd Font", monospace;
          font-weight: bold;
          font-size: 11px;
        }

        window#waybar.hidden { opacity: 0.98; }

        /* ====================== COMMON MODULE STYLE =================== */
        #window,
        #custom-updates,
        #tray,
        #network,
        #wireplumber,
        #battery,
        #backlight,
        #clock,
        #memory,
        #cpu,
        #custom-launcher,
        #custom-bluetooth,
        #idle_inhibitor,
        #custom-mpris-prev,
        #custom-mpris-next,
        #custom-modes,
        #mpris {
          color: @fg;
          margin: 2px 6px;
          padding: 3px 7px;
          border-bottom: 2px solid @muted;
        }

        /* ==================== Power Profiles Daemon =================== */
        #power-profiles-daemon {
          font-size: 14px;
          padding: 3px 7px;
          margin: 2px 6px;
          border-bottom: 2px solid @muted;
          color: @fg;
        }
        #power-profiles-daemon.performance { color: @red;   border-bottom-color: @red; }
        #power-profiles-daemon.balanced   { color: @green; border-bottom-color: @green; }
        #power-profiles-daemon.power-saver{ color: @blue;  border-bottom-color: @blue; }

        /* ======================= Idle Inhibitor ======================= */
        #idle_inhibitor { color: @yellow; border-bottom-color: @yellow; }
        #idle_inhibitor.activated   { color: @green; border-bottom-color: @green; }
        #idle_inhibitor.deactivated { color: @red;   border-bottom-color: @red; }

        /* ============================ CPU ============================= */
        #cpu { color: @green; border-bottom-color: @green; }
        #cpu.warning  { color: @yellow; border-bottom-color: @yellow; }
        #cpu.critical { color: @red;    border-bottom-color: @red; }

        /* =========================== Memory =========================== */
        #memory { color: @aqua; border-bottom-color: @aqua; }
        #memory.warning  { color: @orange; border-bottom-color: @orange; }
        #memory.critical { color: @red;    border-bottom-color: @red; }

        /* =========================== Battery ========================== */
        #battery { color: @bright_green; border-bottom-color: @bright_green; }
        #battery.charging, #battery.plugged { color: @green; border-bottom-color: @green; }
        #battery.warning:not(.charging)  { color: @yellow; border-bottom-color: @yellow; }
        #battery.critical:not(.charging) { color: @red;    border-bottom-color: @red; }

        /* ========================= custom-swaync ======================= */
        #custom-swaync {
          font-size: 12px;
          color: @red;
          border-bottom: 2px solid @red;
          padding: 3px 7px;
          margin: 2px 6px;
        }

        /* ========================= custom-cava ======================== */
        #custom-cava {
          font-size: 12px;
          padding: 0 8px;
          letter-spacing: 1px;
          color: @green;
          border-bottom: 2px solid @green;
          margin: 2px 0;
        }

        /* =========================== Workspaces ======================= */
        #workspaces {
          color: @bg;
          border-bottom: 2px solid @green;
          margin: 2px;
        }
        #workspaces button {
          color: @fg;
          margin: 3px 1px;
          min-width: 20px;
          padding: 0 2px;
        }
        #workspaces button:hover  { background: @bright_green; }
        #workspaces button.active { background: @green; color: @bg; }
        #workspaces button.urgent { background: @bright_red; }

        /* ========================= Window title ======================= */
        #window {
          color: @bg;
          background: @bright_purple;
          border-bottom-color: @blue;
          margin: 2px 6px;
          padding: 3px 7px;
        }
        window#waybar.empty #window {
          margin: 0;
          padding: 0;
          background: transparent;
          color: transparent;
          border-bottom: none;
        }

        /* ============================ Network ========================= */
        #network { color: @orange; border-bottom-color: @orange; }
        #network.disconnected { color: @red; border-bottom-color: @red; }

        /* ============================= Audio ========================== */
        #wireplumber { color: @aqua; border-bottom-color: @aqua; }
        #wireplumber.muted { color: @bright_red; border-bottom-color: @bright_red; }

        /* ============================ Backlight ======================= */
        #backlight { color: @bright_yellow; border-bottom-color: @bright_yellow; }

        /* ============================== Clock ========================= */
        #clock { color: @bright_aqua; border-bottom-color: @bright_aqua; }

        /* =============================== Tray ========================= */
        #tray { padding: 3px 7px; margin: 0 6px; border-bottom-color: @fg; }

        /* ============================= Launcher ======================= */
        #custom-launcher {
          color: @bright_blue;
          font-size: 12px;
          margin: 0 6px;
          border-bottom-color: @bright_blue;
        }

        /* ========================== MPRIS controls ==================== */
        #mpris { color: @aqua; border-bottom-color: @aqua; }
        #mpris:hover { color: @bright_green; border-bottom-color: @bright_green; }
        #custom-mpris-prev, #custom-mpris-next { color: @aqua; border-bottom-color: @aqua; }
        #custom-mpris-prev:hover, #custom-mpris-next:hover { color: @bright_green; border-bottom-color: @bright_green; }

        /* ============================== Taskbar ======================= */
        #taskbar { background: transparent; padding: 0; margin: 0 6px; border-bottom: none; }
        #taskbar button {
          background: transparent;
          border: none;
          margin: 2px 1px;
          padding: 2px;
          color: @fg;
          border-bottom: 2px solid @muted;
          min-width: 14px;
        }
        #taskbar button.active { border-bottom-color: @green; }
        #taskbar button:hover  { border-bottom-color: @bright_green; }
        #taskbar button.urgent { border-bottom-color: @bright_red; }
      #tray, #network, #wireplumber, #battery, #clock, #memory, #cpu,
      #custom-launcher, #idle_inhibitor, #mpris {
        padding: 2px 4px;    /* tighten module padding */
        margin: 1px 4px;     /* reduce spacing between modules */
      }
    '';

  };

  # services.power-profiles-daemon.enable = true; # NixOS
}
