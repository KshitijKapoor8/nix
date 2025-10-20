{
  pkgs,
  lib,
  config,
  hostname,
  ...
}:
let
  isLinux = pkgs.stdenv.isLinux;

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
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";

      bind =
        let
          binding =
            mod: cmd: key: arg:
            "${mod}, ${key}, ${cmd}, ${arg}";
          mvfocus = binding "SUPER" "movefocus";
          ws = binding "SUPER" "workspace";
          mvactive = binding "SUPER SHIFT" "movewindow";
          mvtows = binding "SUPER SHIFT" "movetoworkspace";
          wses = [
            1
            2
            3
            4
            5
            6
            7
            8
            9
          ];
        in
        [
          "$mod, t, exec, ${term}"
          "$mod, space, exec, ${menu}"
          "$mod, b, exec, ${browser}"
          "$mod, e, exec, ${files}"
          "$mod, q, killactive"
          "$mod, m, exec, hyprctl dispatch exit"

          "$mod, p, exec, grim -g \"$(slurp)\" - | wl-copy"

          "$mod, f, togglefloating"
          "$mod shift, f, fullscreen"

          "$mod shift, w, exec, ~/nix/scripts/swww-cycle.sh"

          ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
          ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"

          (mvfocus "k" "u")
          (mvfocus "j" "d")
          (mvfocus "h" "l")
          (mvfocus "l" "r")

          (mvactive "k" "u")
          (mvactive "j" "d")
          (mvactive "h" "l")
          (mvactive "l" "r")
        ]
        ++ (map (i: ws (toString i) (toString i)) wses)
        ++ (map (i: mvtows (toString i) (toString i)) wses);

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
    };
  };
}
