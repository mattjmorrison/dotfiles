{ pkgs, ... }:

{
  home.packages = with pkgs; [
    deadnix
    nil
    nixfmt
    statix
  ];
}
