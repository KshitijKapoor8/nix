{ 
  pkgs, ...
}:
{
  home.packages = with pkgs; [
    ghostty
    wezterm
    kitty
  ];
}
