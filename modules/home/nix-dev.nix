{ pkgs, ... }:

{
  home.packages = with pkgs; [
    deadnix
    lua-language-server
    nil
    nixfmt
    selene
    shellcheck
    shfmt
    statix
    stylua
  ];
}
