{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fzf
    eza
    bat
    tree
    htop
    jq
    curl
    wget
    neofetch
    fastfetch
    zoxide
    sesh
    thefuck
    npm
  ];
}
