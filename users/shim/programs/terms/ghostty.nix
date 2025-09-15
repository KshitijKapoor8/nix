{ pkgs, ... }:
{
    programs.ghostty = {
        enable = true;
        settings = {
            theme = "catppuccin-mocha";
            font-size = 11;
            window-decoration = true;
            # copy-on-select = clipboard;
            background-opacity = 0.5;
        };
    };
}
