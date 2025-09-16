{ config, pkgs, lib, hostname, username, ... }:
{
    home.username = "shim";
    home.homeDirectory = "/home/shim";

    programs.home-manager.enable = true;

    home.packages = with pkgs; [ ];

    home.stateVersion = "24.11";

    programs.git = {
        enable = true;
        userName = "KshitijKapoor8";
        userEmail = "kshitijkapoor8@gmail.com";
    };

    programs.neovim.enable = true;

    imports = [
        ./programs/zsh/zsh.nix
        ./programs/misc/misc.nix
        ./programs/terms/term.nix
        ./programs/starship/starship.nix
        ./programs/nvim/nvim.nix
        ./de/sway/sway.nix
    ];
}

