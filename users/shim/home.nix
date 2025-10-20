{
  config,
  pkgs,
  lib,
  hostname,
  username,
  inputs,
  ...
}:
{
  home.username = "shim";
  home.homeDirectory = "/home/shim";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    inputs.nixvim.packages.${pkgs.stdenv.system}.default
  ];

  home.stateVersion = "24.11";

  programs.git = {
    enable = true;
    userName = "KshitijKapoor8";
    userEmail = "kshitijkapoor8@gmail.com";
    lfs.enable = true;

    extraConfig = {
      core.editor = "nvim";
    };
  };

  imports = [
    ./programs/zsh/zsh.nix
    ./programs/misc/misc.nix
    ./programs/terms/term.nix
    ./programs/starship/starship.nix

    ./programs/browsers
    ./programs/tmux

    ./de/waybar
    ./de/sway/sway.nix
    ./de/hyprland/hyprland.nix
    ./de/niri
  ];
}
