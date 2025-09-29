{
  pkgs,
  lib,
  config,
  hostname,
  ...
}:
let
  isLinux = pkgs.stdenv.isLinux;

  mod = "Mod4";
  term = "ghostty";
  menu = "wofi --show drun";
  browser = "zen-twilight";
  files = "nautilus";

  left = "h";
  down = "j";
  up = "k";
  right = "l";
in
{
  imports = [ ./keybinds.nix ];
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor =
        if hostname == "nixos" then
          [
            ",2880x1920@120,0x0,1.6"
          ]
        else if hostname == "paddington" then
          [
            "DP-1,2560x1440@240,0x0,1"
            "DP-3,1920x1080@144,2560x0,1,transform,3"
          ]
        else
          [ ];

      general = {
        gaps_in = 4;
        gaps_out = 10;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        kb_options = "altwin:swap_alt_win";
        repeat_rate = 60;
        repeat_delay = 180;
        touchpad = {
          natural_scroll = "yes";
          disable_while_typing = true;
          drag_lock = true;
        };

        sensitivity = if hostname == "paddington" then -0.4 else 0;
      }
      // lib.optionalAttrs (hostname == "paddington") {
        accel_profile = "flat";
        kb_options = "altwin:swap_alt_win";
        repeat_rate = 55;
        repeat_delay = 180;
      }
      // lib.optionalAttrs (hostname == "nixos") {
        touchpad = {
          natural_scroll = "yes";
          disable_while_typing = true;
          drag_lock = true;
        };
      };

      animations = {
        enabled = "no";
      };

      decoration = {
        dim_inactive = true;
        inactive_opacity = 0.9;
        rounding = 3;
      };

      misc = {
        disable_hyprland_logo = true;
      };

      env = [
        "XCURSOR_THEME,24"
        "HYPRCURSOR_THEME,24"

        "XCURSOR_THEME,Adwaita"
        "HYPRCURSOR_THEME,Adwaita"
      ];

      workspace = [
        "1, monitor:DP-1, persistent:true"
        "2, monitor:DP-3, persistent:true"
        "3, monitor:DP-1, persistent:true"
        "4, monitor:DP-3, persistent:true"
        "5, monitor:DP-1, persistent:true"
        "6, monitor:DP-3, persistent:true"
        "7, monitor:DP-1, persistent:true"
        "8, monitor:DP-3, persistent:true"
      ];
    };
  };
}
