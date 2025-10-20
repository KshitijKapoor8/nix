{ pkgs, inputs, ... }:
let
  pkgs43 = inputs.godot_4-mono-4-3.legacyPackages.${pkgs.stdenv.system};
in
{
  home.packages = with pkgs; [
    # (pkgs43.godot_4-mono)
    godot_4-mono
  ];
}
