{ config, pkgs, ... }:
{
  programs.qutebrowser = {
    enable = true;

    package = pkgs.qutebrowser.override { enableWideVine = true; };

    settings = {
      content.blocking.enabled = true;
      content.blocking.method = "both";
      content.autoplay = false;
      tabs.position = "top";

      url.default_page = "https://www.google.com/";
      # url.searchengines = {
      #   DEFAULT = "https://www.google.com/search?q={}";
      #   g = "https://www.google.com/search?q={}";
      #   w = "https://en.wikipedia.org/w/index.php?search={}";
      #   yt = "https://www.youtube.com/results?search_query={}";
      #   nix = "https://search.nixos.org/packages?query={}";
      # };
    };
  };
}
