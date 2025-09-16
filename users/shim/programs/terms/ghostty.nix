{ pkgs, ... }:
{
    programs.ghostty = {
        enable = true;
        settings = {
            theme = "tokyonight";
            font-size = 11;
            window-decoration = true;
            # copy-on-select = clipboard;
            background-opacity = 0.7;
        };
    };
}
