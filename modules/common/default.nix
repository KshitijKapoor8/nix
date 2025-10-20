{ pkgs, inputs, ... }:
{
  imports = [ ./stylix.nix ];

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

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      font-awesome
      material-design-icons
    ];
  };

  programs.niri.enable = true;

  services.tailscale.enable = true;
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}
