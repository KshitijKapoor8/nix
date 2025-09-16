{ pkgs, ... }:
{
    services.swayidle = {
        enable = true;
        package = pkgs.swayidle;

        timeouts = [
            {
                timeout = 180;
                command = "exec ghostty";
            }
        ];
    };
}
