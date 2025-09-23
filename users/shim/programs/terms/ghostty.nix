{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Oxocarbon";
      font-size = 12;
      window-decoration = true;
      # copy-on-select = clipboard;
      background-opacity = 0.6;
    };
  };
}
