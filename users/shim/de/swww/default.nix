{
  lib,
  config,
  inputs,
  system,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    swww
  ];
}
