{
  pkgs,
  lib,
  config,
  ...
}:
let
  dir = "/home/shim/nix/users/shim/de/niri/config.kdl";
in
{
  xdg.configFile = {
    niri.source = config.lib.file.mkOutOfStoreSymlink dir;
  };
}
