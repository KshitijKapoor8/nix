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
    settings = { };
    style = lib.mkForce null;
  };

  xdg.configFile."waybar/config".source = ./config.jsonc;
  xdg.configFile."waybar/pic.svg".source = ./pic.svg;
  xdg.configFile."waybar/style.css".source = ./style.css;
  xdg.configFile."waybar/custom-colors.css".source = ./custom-colors.css;
}
