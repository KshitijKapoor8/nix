{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    quickshell
    qt6.qt5compat
    playerctl
  ];

  programs.quickshell.enable = lib.mkForce false;

  xdg.configFile."quickshell/default".source = ./quickshell;
  xdg.configFile."quickshell/horizontal".source = ./quickshell-horizontal;
}
