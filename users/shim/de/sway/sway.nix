{ pkgs, lib, config, hostname, ... }:
let 
    isLinux = pkgs.stdenv.isLinux;

    mod = "Mod4";
    term = "ghostty";
    menu = "wofi --show drun";
    browser = "firefox";
    files = "nautilus";
in
{
    wayland.windowManager.sway = {
        enable = isLinux;
        package = pkgs.swayfx;

        checkConfig = false;

        config = {
            modifier = mod;
            terminal = "ghostty";

            input."type:keyboard".xkb_layout = "us";

            keybindings = {
                # execs
                "${mod}+t" = "exec ${term}";
                "${mod}+b" = "exec ${browser}";
                "${mod}+e" = "exec ${nautilus}";

                "${mod}+space" = "exec ${menu}";

                "${mod}+shift+c" = "reload";
                "${mod}+shift+e" = "exec swaymsg exit";
            };

            output = if hostname == "paddington" then {
                "DP-2" = { mode = "2560x1440@240Hz"; pos = "0 0"; scale = "1.0"; };
                "DP-3" = { mode = "1920x1080@144Hz"; pos = "2560 0"; scale = "1.0"; };
            } else if hostname == "laptop" then {
            } else { };
        };
    };
}
