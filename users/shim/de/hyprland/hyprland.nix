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
      monitor = [
        ",2880x1920@120,0x0,1.6"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 10;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "yes";
          disable_while_typing = true;
          drag_lock = true;
        };
        kb_options = "altwin:swap_alt_win";
        repeat_rate = 60;
        repeat_delay = 220;
      };

      animations = {
        enabled = "no";
      };

      misc = {
        disable_hyprland_logo = true;
      };

      # gestures = {
      #   workspace_swipe = true;
      #   workspace_swipe_forever = true;
      #   workspace_swipe_numbered = true;
      # };
    };
  };
}
