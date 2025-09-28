{ pkgs, inputs, ... }:
{
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    binutils
    pkg-config
    cmake
    clang
    vim
  ];
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };
  users.defaultUserShell = pkgs.zsh;

  imports = [ ./stylix.nix ];

}
