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
    marksman
    markdownlint-cli2
    markdown-toc
  ];

  home.file.".config/nvim" = {
    source = ../../config/nvim;
    recursive = true;
  };
}
