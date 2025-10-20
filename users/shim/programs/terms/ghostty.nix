{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 13;
      window-decoration = true;
      background-opacity = 0.8;
      theme = "my-base16";

      #       background = "#111111"; # base00
      #       foreground = "#cdd6f4"; # base05
      #       cursor-color = "#cdd6f4"; # same as text
      #       selection-background = "#313244"; # base02
      #       selection-foreground = "#cdd6f4";
    };

    themes.my-base16 = {
      background = "111111"; # base00
      foreground = "cdd6f4"; # base05
      cursor-color = "cdd6f4";
      selection-background = "313244";
      selection-foreground = "cdd6f4";

      # palette must be "index=#color" strings
      palette = [
        "0=#111111" # base00 (black)
        "1=#f38ba8" # base08 (red)
        "2=#a6e3a1" # base0B (green)
        "3=#f9e2af" # base0A (yellow)
        "4=#89b4fa" # base0D (blue)
        "5=#cba6f7" # base0E (magenta)
        "6=#94e2d5" # base0C (cyan)
        "7=#cdd6f4" # base05 (white)
        "8=#45475a" # base03 (bright black)
        "9=#fab387" # base09 (bright red)
        "10=#111111" # base01 (bright green)
        "11=#313244" # base02 (bright yellow)
        "12=#585b70" # base04 (bright blue)
        "13=#f5e0dc" # base06 (bright magenta)
        "14=#f2cdcd" # base0F (bright cyan)
        "15=#b4befe" # base07 (bright white)
      ];
    };
  };
}
