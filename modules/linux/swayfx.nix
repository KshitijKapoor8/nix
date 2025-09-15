{ pkgs, lib, ... }:
{
    programs.sway = {
        enable = true;
        package = pkgs.swayfx;

        wrapperFeatures.gtk = true;
    };

    xdg.portal = { 
        enable = true;
        wlr.enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    services.greetd = {
        enable = true;
        settings.default_session = {
            command = "dbus-run-session sway";
            user = "greeter";
        };
    };

    environment.systemPackages = with pkgs; [
        wl-clipboard grim slurp jq
    ];

    security.polkit.enable = true;
}
