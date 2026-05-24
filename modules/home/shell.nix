{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tmux
  ];

  home.file.".tmux.conf".source = ../../config/tmux/tmux.conf;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
