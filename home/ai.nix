{ pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code
    codex
    github-copilot-cli
  ];
}
