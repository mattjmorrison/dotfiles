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
    source = ../../config/nvim;
    recursive = true;
  };
}
