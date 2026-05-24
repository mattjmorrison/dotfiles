{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
    tree-sitter
    nodejs
    gcc
    unzip
    wget
  ];

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
