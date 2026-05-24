{ pkgs, ... }:

{
  imports = [
    ./karabiner.nix
    ./shell.nix
    ./git.nix
    ./neovim.nix
    ./ai.nix
  ];

  home.username = "matt-nix";
  home.stateVersion = "26.05";
}
