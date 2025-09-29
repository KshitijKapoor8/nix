{ pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-city-dark.yaml";
    image = ../../wallpapers/meadow.jpg;
    polarity = "dark";
    autoEnable = true;
  };
}
