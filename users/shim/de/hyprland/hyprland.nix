{ pkgs, lib, config, hostname, ... }:
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
    wayland.windowManager.hyprland = {
        enable = isLinux;
    };
}
