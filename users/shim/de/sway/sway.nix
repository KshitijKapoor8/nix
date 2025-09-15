{ pkgs, ... }:
# let 
#     isLinux = pkgs.stdenv.isLinux;
# in
{
    wayland.windowManager.sway = {
        enable = true;
        package = pkgs.swayfx;

        config = {
            modifier = "Mod4";
            terminal = "ghostty";

            input."type:keyboard".xkb_layout = "us";

            keybindings = {
                "$Mod4 + t" = "exec ghostty";
                "$mod4 + space" = "exec wofi --show drun";
                "$mod4 + shift + c" = "reload";
                "$mod4 + shift + e" = "exec swaymsg exit";
            };
        };
    };
}
