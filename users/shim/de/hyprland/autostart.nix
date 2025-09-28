{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec = [
      "pkill -SIGUSR2 waybar || waybar"
    ];
  };
}
