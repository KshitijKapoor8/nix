{ pkgs, ... }:
{
    home.packages = with pkgs; [
        ripgrep 
        fd
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
        nodejs
        python3
        cargo
        wofi
    ];
}
