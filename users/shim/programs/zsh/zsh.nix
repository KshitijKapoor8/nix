{ pkgs, hostname, ... }:
let
  isFrame = hostname == "nixos";
in
{
  programs.zsh = {
    enable = true;
    initExtra =
      if isFrame then builtins.readFile ./.zshrc-nixos else builtins.readFile ./.zshrc-paddington;
  };
}
