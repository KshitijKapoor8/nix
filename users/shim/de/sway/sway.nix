{ pkgs, lib, config, hostname, ... }:
let 
    isLinux = pkgs.stdenv.isLinux;

    mod = "Mod4";
    term = "ghostty";
    menu = "wofi --show drun";
    browser = "zen-twilight";
    files = "nautilus";

    left = "h";
    down = "j";
    up = "k";
    right = "l";
in
{
    imports = [ ./swayidle.nix ];

    wayland.windowManager.sway = {
        enable = isLinux;
        package = pkgs.swayfx;

        checkConfig = false;

        config = {
            modifier = mod;
            terminal = term;

            input."type:keyboard".xkb_layout = "us";

            keybindings = {
                # execs
                "${mod}+t" = "exec ${term}";
                "${mod}+b" = "exec ${browser}";
                "${mod}+e" = "exec ${files}";
                "${mod}+p" = "exec grim -g \"$(slurp)\" - | wl-copy";
                "${mod}+q" = "kill";

                # Window management
                "${mod}+${left}" = "focus left";
                "${mod}+${right}" = "focus right";
                "${mod}+${up}" = "focus up";
                "${mod}+${down}" = "focus down";
                # with vim motions
                "${mod}+Shift+${left}"  = "move left";
                "${mod}+Shift+${down}"  = "move down";
                "${mod}+Shift+${up}"    = "move up";
                "${mod}+Shift+${right}" = "move right";
                # with arrows
                "${mod}+Shift+Left"  = "move left";
                "${mod}+Shift+Down"  = "move down";
                "${mod}+Shift+Up"    = "move up";
                "${mod}+Shift+Right" = "move right";
                # fullscreen
                "${mod}+Shift+f" = "fullscreen";
                # floating toggle
                "${mod}+f" = "floating toggle";

                # workspaces
                "${mod}+1" = "workspace number 1";
                "${mod}+2" = "workspace number 2";
                "${mod}+3" = "workspace number 3";
                "${mod}+4" = "workspace number 4";
                "${mod}+5" = "workspace number 5";
                "${mod}+6" = "workspace number 6";
                "${mod}+7" = "workspace number 7";
                "${mod}+8" = "workspace number 8";
                "${mod}+9" = "workspace number 9";
                "${mod}+0" = "workspace number 10";

                "${mod}+Shift+1" = "move container to workspace number 1";
                "${mod}+Shift+2" = "move container to workspace number 2";
                "${mod}+Shift+3" = "move container to workspace number 3";
                "${mod}+Shift+4" = "move container to workspace number 4";
                "${mod}+Shift+5" = "move container to workspace number 5";
                "${mod}+Shift+6" = "move container to workspace number 6";
                "${mod}+Shift+7" = "move container to workspace number 7";
                "${mod}+Shift+8" = "move container to workspace number 8";
                "${mod}+Shift+9" = "move container to workspace number 9";
                "${mod}+Shift+0" = "move container to workspace number 10";

                "${mod}+space" = "exec ${menu}";

                "${mod}+shift+c" = "reload";
                "${mod}+shift+e" = "exec swaymsg exit";
            };

            floating.modifier = mod;

            output = if hostname == "paddington" then {
                "DP-1" = { mode = "2560x1440@240Hz"; pos = "0 0"; scale = "1.0"; };
                "DP-3" = { mode = "1920x1080@144Hz"; pos = "2560 0"; scale = "1.0"; transform = "90"; };
            } else if hostname == "laptop" then {
            } else { };

        };

        extraConfig = ''
            corner_radius 10

            blur off
            blur_xray off
            blur_passes 2
            blur_radius 5

            shadows off
            shadows_on_csd off
            shadow_blur_radius 20
            shadow_color #0000007F

            default_dim_inactive 0.0
            dim_inactive_colors.unfocused #000000FF
            dim_inactive_colors.urgent    #900000FF

            scratchpad_minimize disable

            # Wallpaper
            output * bg ~/nix/wallpapers/city.jpeg fill

            # Include extra drop-ins, if any
            include /etc/sway/config.d/*

            workspace 1 output DP-1
            workspace 2 output DP-3
            workspace 3 output DP-1
            workspace 4 output DP-3
            workspace 5 output DP-1
            workspace 6 output DP-3
            workspace 7 output DP-1
            workspace 8 output DP-3
            workspace 9 output DP-1
            workspace 10 output DP-3

            exec_always swaymsg 'focus output DP-1'
            exec_always swaymsg 'workspace number 1'
        '';
    };
}
