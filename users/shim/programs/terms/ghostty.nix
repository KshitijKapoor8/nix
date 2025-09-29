{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 13;
      window-decoration = true;
      # copy-on-select = clipboard;
      background-opacity = 0.8;
    };
  };
}
